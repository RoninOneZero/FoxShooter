extends State

@export var duration: float = 1.0

@export var pawn: Pawn2D
@export var controller: Controller
@export var sprite: AnimatedSprite2D
@export var facing: Facing
# @export var animation_player: AnimationPlayer

var _time := 0.0

func enter() -> void:
	sprite.play(&"ready_weapon")

	_time = 0.0


# func exit() -> void:
#     pass


func update(_delta: float) -> void:
	_time += _delta

	if _time >= duration:
		#TODO Reload check
		state_machine.change_state("shoot_state")
		return


# func physics_update(_delta: float) -> void:
#     pass


# func receive_event(_event: String) -> void:
#     pass
