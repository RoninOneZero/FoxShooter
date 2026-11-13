
@icon("res://addons/at-icons/node3d/chess_pawn.svg")
class_name Pawn2D extends CharacterBody2D

@export var walk_speed: float = 100.0
@export var walk_acceleration: float = 500.0
@export var ground_friction: float = 500.0


@export var jump_height : float = 10.0
@export var jump_time_to_peak : float = 1.0
@export var jump_time_to_descent : float = 1.0

var input_direction := Vector2.ZERO
var movement_enabled := true
var gravity_enabled := true
var ground_friction_enabled := true
var air_friction_enabled := true

# Jump params. multiply by -1 if 2D
@onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
@onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
@onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0


func _physics_process(delta: float) -> void:
	if not movement_enabled:
		velocity = Vector2.ZERO
		return

	if not is_on_floor():
		if gravity_enabled:
			velocity.y += _get_gravity() * delta

	var movement_direction := input_direction * walk_speed

	if movement_direction.x != 0.0:
		velocity = velocity.move_toward(movement_direction, walk_acceleration * delta)
	else:
		if ground_friction_enabled:
			velocity = velocity.move_toward(Vector2.ZERO, ground_friction * delta)

	move_and_slide()


func jump() -> void:
	velocity.y = jump_velocity


func _get_gravity() -> float: # Use > in 3D, < in 2D
	return jump_gravity if velocity.y < 0.0 else fall_gravity
