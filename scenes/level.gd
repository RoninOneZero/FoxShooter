extends Node2D

signal game_lost
signal round_ended()

@export var music: AudioStream
@export var round_time := 60.0
@export var enemy_spawn_delay := 1.0
@export var packed_enemy_scene: PackedScene
@export var packed_stronger_enemy_scene: PackedScene
@export var spawn_delay_timer: Timer
@export var horde_spawn_delay: float

@export var enemy_spawn_points: Array[Node2D] = []
@export var spawn_target_node: Node2D
@export var player: Pawn2D

var last_used_spawn: Node2D

var _enemies: Array[Pawn2D] = []

@onready var time_remaining := round_time
@onready var combat: CombatManager = Main.get_node("GameState/Combat")


func _ready() -> void:
	game_lost.connect(Main._on_game_lost)
	round_ended.connect(Main._on_round_ended)
	round_ended.connect(combat._on_wave_ended)

	var player_health: Health = player.get_node("Health")
	player_health.depleted.connect(_on_player_defeated)

	combat.current_bounty = 0

	initalize_hud()

	$SpawnTimer.start(enemy_spawn_delay)

	Main.play_music(music)


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
		round_ended.emit()


func initalize_hud() -> void:
	var hud: HUD = Main.get_node("UserInterface/HUD")
	var player_health: Health = player.get_node("Health")

	hud.set_max_health(player_health.max_health)
	hud.set_health(player_health.current_health)

	player_health.health_changed.connect(hud.set_health)

	hud.set_kill_count(0)
	hud.set_wave(combat.current_wave)

	hud.show()


func get_horde() -> Array[Pawn2D]:
	var max_enemies := combat.get_max_enemies_for_wave()
	var enemy_budget := max_enemies - _enemies.size()

	if enemy_budget <= 0:
		return []

	var max_group_size := mini(combat.get_horde_size_for_wave(), enemy_budget)
	var amount_to_spawn = randi_range(1, max_group_size)

	var enemies_to_spawn: Array[Pawn2D] = []
	for i in amount_to_spawn:
		enemies_to_spawn.append(packed_enemy_scene.instantiate())
	
	return enemies_to_spawn


func spawn_enemy(enemy: Pawn2D, location: Vector2) -> void:
	var controller := enemy.get_node("AIController") as AIController
	controller.target = player
	controller.face_target()
	var health: Health = enemy.get_node("Health")
	health.depleted.connect(_on_enemy_killed.bind(enemy))

	spawn_target_node.add_child(enemy)
	enemy.global_position = location

	_enemies.append(enemy)
	if _enemies.size() >= combat.get_max_enemies_for_wave():
		spawn_delay_timer.stop()


func get_spawn_point() -> Vector2:
	var modified_list = enemy_spawn_points.duplicate()

	if last_used_spawn != null:
		modified_list.erase(last_used_spawn)

	last_used_spawn = modified_list.pick_random()

	return last_used_spawn.global_position


func spawn_horde() -> void:
	var horde := get_horde()
	if horde.is_empty():
		return

	var spawn_location := get_spawn_point()

	for enemy in horde:
		spawn_enemy(enemy, spawn_location)
		await get_tree().create_timer(horde_spawn_delay).timeout






func _on_player_defeated() -> void:
	game_lost.emit()
	get_tree().paused = true


func _on_enemy_killed(enemy: Pawn2D) -> void:
	var was_full := _enemies.size() >= combat.get_max_enemies_for_wave()
	_enemies.erase(enemy)
	
	combat.current_bounty += 1
	
	var hud: HUD = Main.get_node("UserInterface/HUD")
	hud.set_kill_count(combat.current_bounty)

	if was_full:
		spawn_delay_timer.start(enemy_spawn_delay)


func _on_spawn_timer_timeout() -> void:
	spawn_horde()
