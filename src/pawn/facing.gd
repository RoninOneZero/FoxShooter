class_name Facing extends Node

signal facing_changed(direction: Vector2)

@export var locked: bool = false
@export var pawn: Node
@export var controller: Controller
@export var sprite: AnimatedSprite2D
@export var hit_box: HitBox2D
@export var weapon_ray_cast: RayCast2D
@export var fire_point: Node2D

var direction := Vector2.RIGHT


func _process(_delta: float) -> void:
	if locked: return
	
	if pawn.velocity.x != 0 and controller.direction.x != 0:
		var _facing := Vector2.RIGHT if controller.direction.x > 0 else Vector2.LEFT
		set_facing(_facing)


func set_facing(_direction: Vector2) -> void:
	direction = _direction


	if direction == Vector2.RIGHT:
		sprite.flip_h = false
	else:
		sprite.flip_h = true
	
	if hit_box:
		hit_box.position.x = abs(hit_box.position.x) * _direction.x

	if weapon_ray_cast:
		var target_position := weapon_ray_cast.target_position
		target_position.x = abs(target_position.x) * direction.x
		weapon_ray_cast.target_position = target_position
	
	if fire_point:
		var position = fire_point.position
		position = abs(position) * direction.x
		fire_point.position = position


	facing_changed.emit(direction)
