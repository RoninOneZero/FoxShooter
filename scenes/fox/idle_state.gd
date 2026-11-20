extends State

@export var pawn: Pawn2D
@export var controller: Controller
@export var sprite: AnimatedSprite2D
@export var facing: Facing
# @export var animation_player: AnimationPlayer
@export var weapon: Weapon


func enter() -> void:
	sprite.play("idle")


# func exit() -> void:
#     pass


func update(_delta: float) -> void:
	if controller.attack_pressed:
		if weapon.can_activate():
			state_machine.change_state(&"preaimstate")
		elif weapon.rounds == 0:
			state_machine.change_state(&"reload_state")
		return

	
	if controller.direction != Vector2.ZERO:
		state_machine.change_state(&"walk_state")
		return
	


# func physics_update(_delta: float) -> void:
#     pass


func receive_event(_event: String) -> void:
	match _event:
		"melee":
			state_machine.change_state("slash_state")
