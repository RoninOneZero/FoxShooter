extends State

@export var pawn: Pawn2D
@export var controller: Controller
@export var sprite: AnimatedSprite2D
@export var facing: Facing
# @export var animation_player: AnimationPlayer
@export var hit_box: HitBox2D
@export var hurt_box: HurtBox2D


func enter() -> void:
	sprite.play("die")
	#TODO remvoe offset when sprite is updated
	sprite.offset = Vector2(0.0, 30.0)

	hit_box.disable()
	hurt_box.process_mode = Node.PROCESS_MODE_DISABLED



func exit() -> void:
	sprite.offset = Vector2.ZERO


# func update(_delta: float) -> void:
#     pass


# func physics_update(_delta: float) -> void:
#     pass


# func receive_event(_event: String) -> void:
#     pass
