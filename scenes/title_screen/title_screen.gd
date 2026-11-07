extends Control

@export_file("*.tscn") var starting_level_path: String

@export var music: AudioStream

@export var credits_node: Credits
@export var options_node: OptionsMenu
@export var start_game: Button
@export var quit_game_button: Button

func _ready() -> void:

	if OS.get_name() == "Web":
		quit_game_button.hide()
	
	credits_node.hide()
	credits_node.return_requested.connect(_on_return_requested.bind(credits_node))
	options_node.hide()
	options_node.return_requested.connect(_on_return_requested.bind(options_node))
	
	var anim: AnimationPlayer = $AnimationPlayer
	anim.play("intro")

	if music:
		Main.play_music(music)
	
	await anim.animation_finished

	start_game.grab_focus()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or \
		event.is_action_pressed("ui_cancel"):
		var anim: AnimationPlayer = $AnimationPlayer
		if anim.is_playing():
			anim.play("RESET")


func _on_start_game_pressed() -> void:
	if starting_level_path == null:
		printerr("No starting level was set!")
		return

	var combat: CombatManager = Main.get_node("GameState/Combat")
	combat.current_wave = 1
	get_tree().change_scene_to_file(starting_level_path)


func _on_quit_game_pressed() -> void:
	Main.quit()


func _on_options_pressed() -> void:
	$MenuButtons.hide()
	options_node.show()


func _on_credits_pressed() -> void:
	$MenuButtons.hide()
	credits_node.show()


func _on_return_requested(control: Control) -> void:
	control.hide()
	$MenuButtons.show()
	start_game.grab_focus()
