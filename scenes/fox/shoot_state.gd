extends State

@export var pawn: Pawn2D
@export var controller: Controller
@export var sprite: AnimatedSprite2D
@export var facing: Facing
@export var weapon: Weapon


func enter() -> void:
	sprite.stop()
	sprite.play("shoot")

	weapon.activate()

	await sprite.animation_finished
	if is_active:
		state_machine.change_state(&"aim_state")

	



# func exit() -> void:
#     pass


func update(_delta: float) -> void:
	if controller.attack_pressed and weapon.can_activate():
		state_machine.change_state(&"shoot_state", true)
		return


# func physics_update(_delta: float) -> void:
#     pass


func receive_event(_event: String) -> void:
	pass

