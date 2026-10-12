class_name Fox extends Pawn2D

@onready var facing: Facing = $Facing
@onready var state_machine: StateMachine = $StateMachine

func _physics_process(delta: float) -> void:
	super(delta)
	if input_direction and facing:
		facing.set_facing(input_direction)


func _on_hurt_box_2d_damage_taken(data: DamageData) -> void:
	print("Ouch!")
	$AnimationPlayer.play("invulnerability")
	state_machine.change_state("hurt_state")
	


func _on_invulnerability_timer_timeout() -> void:
	$HurtBox2D.enabled = true
	$AnimationPlayer.play("RESET")