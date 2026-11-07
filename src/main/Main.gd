@icon("res://addons/at-icons/node/gobot.svg")
extends Node

@export_file("*.tscn") var title_screen_file_path

@export var hud: HUD
@export var music_player: AudioStreamPlayer
@export var game_over: GameOver
@export var pause_menu: PauseMenu
@export var shop_menu: Control


func _ready() -> void:
	var combat: CombatManager = get_node("GameState/Combat")
	hud.set_wave(combat.current_wave)
	hud.hide()
	game_over.hide()
	pause_menu.hide()
	shop_menu.hide()

	game_over.title_screen_requested.connect(_on_title_screen_requested)
	pause_menu.title_screen_requested.connect(_on_title_screen_requested)
	pause_menu.continue_requested.connect(_on_continue_requested)
	shop_menu.continue_requested.connect(_on_shop_exited)


func play_music(music_stream: AudioStream) -> void:
	if music_player.stream == music_stream:
		return

	music_player.stream = music_stream
	music_player.play()


func pause_game() -> void:
	get_tree().paused = true
	pause_menu.show()


func quit() -> void:
	var combat: CombatManager = get_node("GameState/Combat")
	print(combat.combat_log)
	print("Exiting game!")
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
	

#TODO move these to game state
func _on_game_lost() -> void:
	game_over.show()


func _on_round_ended() -> void:
	var inventory: Inventory = get_node("GameState/Inventory")
	var combat: CombatManager = get_node("GameState/Combat")
	inventory.add_cash_from_bounty(combat.current_bounty)
	shop_menu.show()


func _on_title_screen_requested() -> void:
	hud.hide()
	game_over.hide()
	pause_menu.hide()

	get_tree().change_scene_to_file(title_screen_file_path)
	get_tree().paused = false


func _on_continue_requested() -> void:
	pause_menu.hide()
	get_tree().paused = false


func _on_shop_exited() -> void:
	var combat: CombatManager = get_node("GameState/Combat")
	combat.current_wave += 1
	hud.set_wave(combat.current_wave)

	shop_menu.hide()
	get_tree().reload_current_scene()
	get_tree().paused = false
