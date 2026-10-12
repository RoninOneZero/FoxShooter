@icon("res://addons/at-icons/node3d/checkerboard.svg")
class_name BattleSlots extends Node3D

var slots: Array[Marker3D] = []

func _ready() -> void:
	var children = get_children()
	for child in children:
		if child is Marker3D:
			slots.append(child)
	
