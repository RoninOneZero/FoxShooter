@icon("res://addons/at-icons/node/bug.svg")
extends CanvasLayer

@export var input_overlay: Control

var enabled := false :
	set(x):
		enabled = x
		if enabled:
			show()
			print_debug("Debug overlay enabled!")
		else:
			hide()
			print_debug("Debug overlay disabled!")


func _ready() -> void:
	if not enabled:
		hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_3"):
		enabled = !enabled
