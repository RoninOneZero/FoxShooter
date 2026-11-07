@icon("res://addons/at-icons/node/swords.svg")

class_name CombatManager extends Node

var current_wave: int = 0
var current_bounty: int = 0

@export var combat_log: Array = []

var horde_sizes = [
	2, # + 0
	3, # + 1
	3, # + 2
	5, # + 3
]

var max_enemies = [
	3,
	5,
	8,
	12,
]


func get_horde_size_for_wave() -> int:
	if current_wave < 5:
		return horde_sizes[0]
	
	if current_wave < 10:
		return horde_sizes[1]
	
	if current_wave < 15:
		return horde_sizes[2]
	
	if current_wave < 20:
		return horde_sizes[3]
	
	return horde_sizes[-1]


func get_max_enemies_for_wave() -> int:
	if current_wave < 5:
		return max_enemies[0]
	
	if current_wave < 10:
		return max_enemies[1]
	
	if current_wave < 15:
		return max_enemies[2]
	
	if current_wave < 20:
		return max_enemies[3]
	
	return horde_sizes[-1]

func _on_wave_ended() -> void:
	combat_log.append(current_bounty)


func _on_tree_exiting() -> void:
	print("sus!")
	print(combat_log)
