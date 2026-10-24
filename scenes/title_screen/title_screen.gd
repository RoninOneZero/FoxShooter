extends Control

@export_file("*.tscn") var starting_level_path: String

@export var quit_game_button: Button

func _ready() -> void:
	if OS.get_name() == "Web":
		quit_game_button.hide()


func _on_start_game_pressed() -> void:
	if starting_level_path == null:
		printerr("No starting level was set!")
		return

	get_tree().change_scene_to_file(starting_level_path)


func _on_quit_game_pressed() -> void:
	get_tree().quit()
