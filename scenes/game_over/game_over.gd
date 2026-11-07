class_name GameOver extends Control

signal title_screen_requested


func _on_title_screen_button_pressed() -> void:
    title_screen_requested.emit()


func _on_visibility_changed() -> void:
    if visible:
        $VBoxContainer/TitleScreenButton.grab_focus()