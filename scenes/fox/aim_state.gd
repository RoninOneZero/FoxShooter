extends State

@export var pawn: Pawn2D
@export var controller: Controller
@export var sprite: AnimatedSprite2D
@export var facing: Facing
# @export var animation_player: AnimationPlayer


func enter() -> void:
	sprite.play("aim")


# func exit() -> void:
#     pass


func update(_delta: float) -> void:
	if controller.direction != Vector2.ZERO:
		state_machine.change_state("walk_state")
		return

# func physics_update(_delta: float) -> void:
#     pass


func receive_event(_event: String) -> void:
	match _event:
		"attack": state_machine.change_state("shoot_state")