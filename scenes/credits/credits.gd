class_name Credits extends Control

signal return_requested

@export var return_button: Button

func _ready() -> void:
    return_button.pressed.connect(return_requested.emit)
    visibility_changed.connect(_on_visibility_changed)


func _on_visibility_changed() -> void:
    if visible:
        return_button.grab_focus()