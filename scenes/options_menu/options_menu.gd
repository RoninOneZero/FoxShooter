class_name OptionsMenu extends Control

signal return_requested

@export var fullscreen_toggle: CheckButton
@export var audio_slider: Slider

func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)

	update_menu()



func update_menu() -> void:
	var current_screen_mode := DisplayServer.window_get_mode()
	if current_screen_mode == DisplayServer.WINDOW_MODE_FULLSCREEN or current_screen_mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		fullscreen_toggle.button_pressed = true
	else:
		fullscreen_toggle.button_pressed = false
	

	var master_volume := AudioServer.get_bus_volume_linear(0)
	audio_slider.value = master_volume

func _on_fullscreen_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_audio_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(0, value)


func _on_return_button_pressed() -> void:
	return_requested.emit()


func _on_visibility_changed() -> void:
	if visible:
		$ReturnButton.grab_focus()
