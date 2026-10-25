extends Node2D

signal game_lost
signal round_ended(bounty_value: int)

@export var round_time := 60.0
@export var packed_enemy_scene: PackedScene
@export var enemy_spawn_point: Marker2D
@export var player: Pawn2D

var kills := 0


@onready var time_remaining := round_time

func _ready() -> void:
	game_lost.connect(Main._on_game_lost)
	round_ended.connect(Main._on_round_ended)

	var player_health: Health = player.get_node("Health")
	player_health.depleted.connect(_on_player_defeated)

	initalize_hud()

	spawn_enemy()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Main.pause_game()


func _process(delta: float) -> void:
	time_remaining -= delta

	if time_remaining < 0.0:
		time_remaining = 0.0

	Main.hud.set_time(time_remaining)

	if time_remaining <= 0.0:
		get_tree().paused = true
		round_ended.emit(kills)


func initalize_hud() -> void:
	var hud: HUD = Main.get_node("UserInterface/HUD")
	var player_health: Health = player.get_node("Health")

	hud.set_max_health(player_health.max_health)
	hud.set_health(player_health.current_health)

	player_health.health_changed.connect(hud.set_health)

	hud.set_kill_count(0)

	hud.show()


func spawn_enemy() -> void:
	var enemy: Pawn2D = packed_enemy_scene.instantiate()

	var controller := enemy.get_node("AIController") as AIController
	controller.target = player
	controller.face_target()
	var health: Health = enemy.get_node("Health")
	health.depleted.connect(_on_enemy_killed)


	enemy.global_position = enemy_spawn_point.global_position
	add_child(enemy)



func _on_player_defeated() -> void:
	game_lost.emit()
	get_tree().paused = true


func _on_enemy_killed() -> void:
	kills += 1
	
	var hud: HUD = Main.get_node("UserInterface/HUD")
	hud.set_kill_count(kills)


func _on_spawn_timer_timeout() -> void:
	spawn_enemy()