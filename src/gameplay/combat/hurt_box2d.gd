class_name HurtBox2D extends Area2D

signal damage_taken(data: DamageData)

@export var enabled := true :
    set(x):
        enabled = x
        set_deferred("monitorable", enabled)


func take_damage(data:DamageData):
    if enabled:
        damage_taken.emit(data)
