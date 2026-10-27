class_name Lizardman extends Pawn2D

@onready var sprite := $AnimatedSprite2D as AnimatedSprite2D
@onready var state_machine := $StateMachine as StateMachine
@onready var health: Health = $Health
@onready var visible_on_screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _on_hurt_box_2d_damage_taken(data: DamageData) -> void:
	if not visible_on_screen_notifier.is_on_screen():
		return

	health.current_health -= data.amount

	if health.current_health > 0:
		# knocback based on damage knockback
		# if stagger chance succeedes, go to hurt state
		state_machine.change_state("hurt_state", true)
		var knockback_velocity := data.direction.x * data.knockback
		print(knockback_velocity)
		velocity.x = knockback_velocity

	else:
		state_machine.change_state("dead_state")
		_on_health_depleted()


func _on_health_depleted() -> void:
	pass


func _on_hurt_state_entered() -> void:
	$HitBox2D.disable()


func _on_idle_state_entered() -> void:
	$HitBox2D.trigger()
