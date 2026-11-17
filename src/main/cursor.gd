@icon("res://addons/at-icons/node/cursor.svg")
class_name Cursor extends Node

@export var speed: float = 1000.0
@export var debug_label: Label
@export var cursor_sprite: Sprite2D
@export var enabled: bool = true

func _ready() -> void:
	if enabled:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	else:
		hide_cusor()


func _process(delta: float) -> void:
	if not enabled:
		return
	
	var new_position := get_window().get_mouse_position()

	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		new_position = new_position + direction * speed * delta
		get_viewport().warp_mouse(new_position)
	
	cursor_sprite.global_position = new_position


	if debug_label:
		debug_label.text = "Mouse: %s \n" % get_window().get_mouse_position()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_send_virtual_left_click(get_window().get_mouse_position())


func show_cursor() -> void:
	if enabled:
		cursor_sprite.show()
	

func hide_cusor() -> void:
	cursor_sprite.hide()


func _send_virtual_left_click(click_position: Vector2) -> void:
	var pressed_event := InputEventMouseButton.new()
	pressed_event.button_index = MOUSE_BUTTON_LEFT
	pressed_event.position = click_position
	pressed_event.pressed = true
	Input.parse_input_event(pressed_event)

	await get_tree().process_frame

	var released_event := InputEventMouseButton.new()
	released_event.button_index = MOUSE_BUTTON_LEFT
	released_event.position = click_position
	released_event.pressed = false
	Input.parse_input_event(released_event)
