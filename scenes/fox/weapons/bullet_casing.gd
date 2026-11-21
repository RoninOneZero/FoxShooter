extends RigidBody2D

@export var fade_time: float = 1.0
@export var audio_fade_time: float = 1.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

# func _ready() -> void:
# 	fade_out()


func fade_out() -> void:
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(sprite, "modulate:a", 0.0, fade_time)
	tween.tween_property(sfx,"volume_linear", 0.0, audio_fade_time)
	await tween.finished
	queue_free()



func _on_body_entered(_body: Node) -> void:
	sfx.play()
	fade_out()
