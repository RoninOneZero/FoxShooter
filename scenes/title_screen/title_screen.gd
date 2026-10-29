extends Control

@export_file("*.tscn") var starting_level_path: String

@export var music: AudioStream

@export var credits_node: Credits
@export var options_node: OptionsMenu
@export var start_game: Button
@export var quit_game_button: Button

func _ready() -> void:
	start_game.grab_focus()

	if OS.get_name() == "Web":
		quit_game_button.hide()
	
	credits_node.hide()
	credits_node.return_requested.connect(_on_return_requested.bind(credits_node))
	options_node.hide()
	options_node.return_requested.connect(_on_return_requested.bind(options_node))

	if music:
		Main.play_music(music)

func _on_start_game_pressed() -> void:
	if starting_level_path == null:
		printerr("No starting level was set!")
		return

	get_tree().change_scene_to_file(starting_level_path)


func _on_quit_game_pressed() -> void:
	get_tree().quit()


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
