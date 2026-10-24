@icon("res://addons/at-icons/node/heart.svg")
class_name Health extends Node

signal health_changed(amount:int)
signal depleted

@export var max_health := 5

var current_health := 5 : set = set_current_health


func _ready() -> void:
    init_health()


func init_health() -> void:
    current_health = max_health


func set_current_health(value:int) -> void:
    if value < 0: 
        value = 0

    current_health = value
    health_changed.emit(value)

    if value <= 0:
        depleted.emit()
    
    

