extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	sprite.animation_finished.connect(_on_animation_finished)


func _on_hurt_box_2d_damage_taken(data: DamageData) -> void:
	sprite.play("hurt")


func _on_animation_finished() -> void:
	sprite.play("idle")