extends Node2D

signal game_lost
signal round_ended(bounty_value: int)

@export var round_time := 60.0
@export var enemy_spawn_delay := 1.0
@export var packed_enemy_scene: PackedScene
@export var packed_stronger_enemy_scene: PackedScene

@export var enemy_spawn_points: Array[Node2D] = []
@export var player: Pawn2D

var kills := 0
var last_used_spawn: Node2D

@onready var time_remaining := round_time

func _ready() -> void:
	game_lost.connect(Main._on_game_lost)
	round_ended.connect(Main._on_round_ended)

	var player_health: Health = player.get_node("Health")
	player_health.depleted.connect(_on_player_defeated)

	initalize_hud()

	$SpawnTimer.start(enemy_spawn_delay)


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
	var game_state: GameState = Main.get_node("GameState")
	var stronger_enemy_chance: float = game_state.current_wave * 0.1
	var random_enemy: PackedScene = packed_enemy_scene if randf() > stronger_enemy_chance else packed_stronger_enemy_scene

	var enemy: Pawn2D = random_enemy.instantiate()
	var controller := enemy.get_node("AIController") as AIController
	controller.target = player
	controller.face_target()
	var health: Health = enemy.get_node("Health")
	health.depleted.connect(_on_enemy_killed)


	enemy.global_position = get_spawn_point()
	add_child(enemy)


func get_spawn_point() -> Vector2:
	var modified_list = enemy_spawn_points.duplicate()

	if last_used_spawn != null:
		modified_list.erase(last_used_spawn)

	last_used_spawn = modified_list.pick_random()

	return last_used_spawn.global_position


func _on_player_defeated() -> void:
	game_lost.emit()
	get_tree().paused = true


func _on_enemy_killed() -> void:
	kills += 1
	
	var hud: HUD = Main.get_node("UserInterface/HUD")
	hud.set_kill_count(kills)


func _on_spawn_timer_timeout() -> void:
	spawn_enemy()