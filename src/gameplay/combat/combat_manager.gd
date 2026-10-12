@icon("res://addons/at-icons/node/swords.svg")
class_name CombatManager extends Node

@export var enabled := true
@export var enemy: Node3D
@export var player: Node3D


func _ready() -> void:
	if not enemy:
		return
	
	if not player:
		return


	enemy.set_target(player)
