class_name Facing extends Node

signal facing_changed(direction: Vector2)

@export var locked: bool = false
@export var pawn: Node
@export var controller: Controller
@export var sprite: AnimatedSprite2D
@export var hit_box: HitBox2D
@export var weapon: Weapon

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

	if weapon:
		weapon.scale.x = direction.x


	facing_changed.emit(direction)
