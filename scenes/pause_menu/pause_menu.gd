class_name PauseMenu extends Control

signal continue_requested
signal title_screen_requested


func _on_continue_button_pressed() -> void:
    continue_requested.emit()


func _on_title_screen_button_pressed() -> void:
    title_screen_requested.emit()


func _on_visibility_changed() -> void:
    if visible:
        $VBoxContainer/ContinueButton.grab_focus()