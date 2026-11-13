extends State

@export var pawn: Pawn2D
@export var controller: Controller
@export var sprite: AnimatedSprite2D
@export var facing: Facing
# @export var animation_player: AnimationPlayer
@export var weapon: Weapon

func enter() -> void:
	sprite.play("walk")


func exit() -> void:
	pawn.input_direction = Vector2.ZERO


# func update(_delta: float) -> void:
#     pass


func physics_update(_delta: float) -> void:
	pawn.input_direction = controller.direction

	if controller.direction == Vector2.ZERO:
		state_machine.change_state("idle_state")
		return


func receive_event(_event: String) -> void:
	match _event:
		"attack": 
			state_machine.change_state("aim_state")
		"melee":
			if %KnifeRefire.time_left == 0.0:
				state_machine.change_state("slash_state")