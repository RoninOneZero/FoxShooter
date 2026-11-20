extends Node2D

signal game_lost
signal round_ended()

@export var music: AudioStream
@export var round_time := 60.0
# @export var enemy_spawn_delay := 1.0
# @export var horde_spawn_delay: float
@export var packed_enemy_scene: PackedScene
@export var packed_stronger_enemy_scene: PackedScene

@export var spawn_timer: SpawnTimer
@export var enemy_spawn_points: Array[Node2D] = []
@export var spawn_target_node: Node2D
@export var player: Pawn2D


var _enemies: Array[Pawn2D] = []

@onready var time_remaining := round_time

@onready var game_state: GameState = Main.get_node("GameState")
@onready var combat: CombatManager = Main.get_node("GameState/Combat")


func _ready() -> void:
	game_lost.connect(Main._on_game_lost)
	round_ended.connect(Main._on_round_ended)
	round_ended.connect(combat._on_wave_ended)

	var player_health: Health = player.get_node("Health")
	player_health.depleted.connect(_on_player_defeated)
	var saved_health = game_state.player_health
	if saved_health > 0:
		player_health.current_health = saved_health

	# Configure spawn timer
	spawn_timer.max_enemies = combat.get_max_enemies_for_wave()
	spawn_timer.max_spawn_rate = 1.3


	combat.current_bounty = 0

	initalize_hud()


	Main.play_music(music)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		Main.pause_game()
		get_window().set_input_as_handled()
	


func _process(delta: float) -> void:
	time_remaining -= delta

	if time_remaining < 0.0:
		time_remaining = 0.0

	Main.hud.set_time(time_remaining)
	spawn_timer.enemies = _enemies.size()

	if time_remaining <= 0.0:
		get_tree().paused = true
		round_ended.emit()


func initalize_hud() -> void:
	var hud: HUD = Main.get_node("UserInterface/HUD")
	var player_health: PlayerHealth = player.get_node("Health")
	var inventory : Inventory = Main.get_node("GameState/Inventory")

	hud.set_max_health(player_health.max_health)
	hud.set_health(player_health.current_health)
	hud.set_med_kits(inventory.med_kits)

	player_health.health_changed.connect(hud.set_health)

	if not inventory.med_kits_changed.is_connected(hud.set_med_kits):
		inventory.med_kits_changed.connect(hud.set_med_kits)
	
	if not inventory.mines_changed.is_connected(hud.set_mines):
		inventory.mines_changed.connect(hud.set_mines)

	hud.set_kill_count(0)
	hud.set_wave(combat.current_wave)

	hud.show()


func spawn_enemy(enemy: Pawn2D, location: Vector2) -> void:
	var controller := enemy.get_node("AIController") as AIController
	controller.target = player
	controller.face_target()
	var health: Health = enemy.get_node("Health")
	health.depleted.connect(_on_enemy_killed.bind(enemy))

	spawn_target_node.add_child(enemy)
	enemy.global_position = location

	_enemies.append(enemy)


func spawn_group() -> void:
	# Determine group size
	var size := 3
	if _enemies.size() + size >= combat.get_max_enemies_for_wave():
		size = 1

	var new_enemies: Array[Pawn2D] = []

	# Determine group composition
	var elite_chance := combat.current_wave / 50.0

	for i in size:
		var chance := randf()

		if chance <= elite_chance:
			new_enemies.append(packed_stronger_enemy_scene.instantiate())
		else:
			new_enemies.append(packed_enemy_scene.instantiate())
		


	# Spawn nodes
	for enemy in new_enemies:
		var random_spawn: Node2D = enemy_spawn_points.pick_random()
		var spawn_point: Vector2 = random_spawn.global_position
		spawn_enemy(enemy, spawn_point)


func _on_player_defeated() -> void:
	game_lost.emit()
	get_tree().paused = true


func _on_enemy_killed(enemy: Pawn2D) -> void:
	_enemies.erase(enemy)	
	combat.current_bounty += 1
	
	var hud: HUD = Main.get_node("UserInterface/HUD")
	hud.set_kill_count(combat.current_bounty)


func _on_spawn_timer_timeout() -> void:
	spawn_group()
