extends Node2D

signal game_lost

const ENEMIES_GROUP := "Enemies"

@export var player: Pawn2D

var kills := 0

func _ready() -> void:
	var enemies := get_tree().get_nodes_in_group(ENEMIES_GROUP)

	for enemy: Pawn2D in enemies:
		var controller := enemy.get_node("AIController") as AIController
		controller.target = player
		controller.face_target()

		var health: Health = enemy.get_node("Health")
		health.depleted.connect(_on_enemy_killed)

	game_lost.connect(Main._on_game_lost)

	var player_health: Health = player.get_node("Health")
	player_health.depleted.connect(_on_player_defeated)

	initalize_hud()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		Main.pause_game()


func initalize_hud() -> void:
	var hud: HUD = Main.get_node("UserInterface/HUD")
	var player_health: Health = player.get_node("Health")

	hud.set_max_health(player_health.max_health)
	hud.set_health(player_health.current_health)

	player_health.health_changed.connect(hud.set_health)

	hud.set_kill_count(0)

	hud.show()


func _on_player_defeated() -> void:
	game_lost.emit()
	get_tree().paused = true


func _on_enemy_killed() -> void:
	kills += 1
	
	var hud: HUD = Main.get_node("UserInterface/HUD")
	hud.set_kill_count(kills)