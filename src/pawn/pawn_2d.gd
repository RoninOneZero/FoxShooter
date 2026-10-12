
@icon("res://addons/at-icons/node3d/chess_pawn.svg")
class_name Pawn2D extends CharacterBody2D

@export var walk_speed: float = 10.0

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
	if not is_on_floor():
		velocity.y += _get_gravity() * delta

	if not movement_enabled:
		input_direction = Vector2.ZERO
	var move_direction := input_direction.normalized()

	if move_direction: 
		velocity.x = move_direction.x * walk_speed
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0.0, walk_speed)


	move_and_slide()


func jump() -> void:
	velocity.y = jump_velocity


func _get_gravity() -> float: # Use > in 3D, < in 2D
	return jump_gravity if velocity.y < 0.0 else fall_gravity
