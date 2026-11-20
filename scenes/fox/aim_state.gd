extends State



@export var pawn: Pawn2D
@export var controller: Controller
@export var sprite: AnimatedSprite2D
@export var facing: Facing
# @export var animation_player: AnimationPlayer
@export var weapon: Weapon

var ready_to_fire := false


func enter() -> void:
	if state_machine.previous_state.name == "":
		pass


	sprite.play("aim")
	ready_to_fire = false

	

	await sprite.animation_finished
	if is_active:
		ready_to_fire = true


# func exit() -> void:
#     pass


func update(_delta: float) -> void:
	if controller.direction != Vector2.ZERO and not controller.attack_pressed:
		state_machine.change_state("walk_state")
		return
	
	if ready_to_fire and weapon.can_activate() and controller.attack_pressed:
		sprite.stop()
		sprite.play("shoot")
		weapon.activate()
		return
	


# func physics_update(_delta: float) -> void:
# 	if not controller.attack_pressed:
# 		state_machine.change_state("idle_state")


func receive_event(_event: String) -> void:
	match _event:
		"attack":
			if weapon.rounds == 0:
				state_machine.change_state(&"reload_state")
		"melee":
			if %KnifeRefire.time_left == 0.0:
				state_machine.change_state(&"slash_state")