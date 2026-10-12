extends State

@export var pawn: Pawn2D
@export var controller: Controller
@export var sprite: AnimatedSprite2D
@export var facing: Facing
# @export var animation_player: AnimationPlayer


func enter() -> void:
	sprite.play("hurt")


# func exit() -> void:
#     pass


# func update(_delta: float) -> void:
#     pass


# func physics_update(_delta: float) -> void:
#     pass


# func receive_event(_event: String) -> void:
#     pass
