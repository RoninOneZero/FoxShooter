extends State

@export var pawn: Pawn2D
@export var controller: Controller
@export var sprite: AnimatedSprite2D
@export var facing: Facing
@export var weapon: Weapon

func enter() -> void:
	sprite.stop()
	sprite.play("shoot")
	pawn.movement_enabled = false

	await sprite.animation_finished
	if is_active:
		state_machine.change_state("aim_state")


# func exit() -> void:
#     pass


# func update(_delta: float) -> void:
#     pass


# func physics_update(_delta: float) -> void:
#     pass


func receive_event(_event: String) -> void:
	match _event:
		"attack": 
			var did_activate := weapon.activate()
			if did_activate:
				state_machine.change_state("aim_state")