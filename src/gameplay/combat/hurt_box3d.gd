@icon("res://addons/at-icons/node3d/heart_broken.svg")
class_name HurtBox3D extends Area3D

signal damage_taken(data: DamageData)

@export var enabled := true :
    set(x):
        enabled = x
        set_deferred("monitorable", enabled)

func take_damage(data:DamageData):
    if enabled:
        damage_taken.emit(data)
