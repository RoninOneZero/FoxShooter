extends State

@export var state_duration := 0.15

@export var pawn: Pawn2D
@export var controller: Controller
@export var sprite: AnimatedSprite2D
@export var facing: Facing
# @export var animation_player: AnimationPlayer
@export var hurt_box: HurtBox2D
@export var invulnerability_timer: Timer

var _time := 0.0


func enter() -> void:
	sprite.play("hurt")
	pawn.movement_enabled = false

	_time = 0.0
	if hurt_box:
		hurt_box.enabled = false
	if invulnerability_timer:
		invulnerability_timer.start()


# func exit() -> void:
#     pass


func update(_delta: float) -> void:
	_time += _delta

	if _time >= state_duration:
		state_machine.change_state("idle_state")
		return

# func physics_update(_delta: float) -> void:
#     pass


# func receive_event(_event: String) -> void:
#     pass
