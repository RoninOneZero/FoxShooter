extends State

@export var duration := 0.5
@export var refire_time := 1.0
@export var knockback_force := 400.0

@export_group("Nodes")
@export var pawn: Pawn2D
@export var controller: Controller
@export var sprite: AnimatedSprite2D
@export var facing: Facing
@export var hit_box: HitBox2D
# @export var animation_player: AnimationPlayer

var _time := 0.0

func enter() -> void:
	sprite.play("slash")
	%KnifeRefire.start(refire_time)

	pawn.movement_enabled = false
	_time = 0.0

	var damage_data := DamageData.new()
	damage_data.knockback = knockback_force

	#TODO add extra knockback
	hit_box.trigger(damage_data, 0.1)


# func exit() -> void:
#     pass


func update(_delta: float) -> void:
	_time += _delta

	if _time >= duration:
		state_machine.change_state("idle_state")
		return


# func physics_update(_delta: float) -> void:
#     pass


# func receive_event(_event: String) -> void:
#     pass
