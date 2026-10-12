class_name Lizardman extends Pawn2D

@onready var sprite := $AnimatedSprite2D as AnimatedSprite2D
@onready var state_machine := $StateMachine as StateMachine

func _on_hurt_box_2d_damage_taken(data: DamageData) -> void:
    # knocback based on damage knockback
    # if stagger chance succeedes, go to hurt state
    state_machine.change_state("hurt_state", true)    


func _on_hurt_state_entered() -> void:
    print("yeow!")
    $HitBox2D.disable()

func _on_idle_state_entered() -> void:
    $HitBox2D.trigger()