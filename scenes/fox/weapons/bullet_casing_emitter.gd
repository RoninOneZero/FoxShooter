class_name BulletCasingEmitter extends Node2D


@export var bullet_casing: PackedScene
@export var eject_velocity: Vector2 = Vector2.ZERO
@export var angular_velocity: float = 0.0
@export_range(0.0, 1.0) var angular_randomness := 0.0




func get_casing(direction:Vector2) -> RigidBody2D:
	var new_casing: RigidBody2D = bullet_casing.instantiate()
	new_casing.global_position = global_position
	new_casing.linear_velocity = eject_velocity * direction

	var base_angle := deg_to_rad(angular_velocity)
	var offset := base_angle * angular_randomness

	new_casing.angular_velocity = base_angle * randf_range(-offset, offset)

	return new_casing

	