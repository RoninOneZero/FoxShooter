@icon("res://addons/at-icons/node/swords.svg")
class_name CombatManager extends Node

var current_wave: int = 0
var current_bounty: int = 0
var combat_log: Array = []

var difficulty_stages: Array[int] = [1]

func get_max_enemies_for_wave(wave: int = -1) -> int:
	if wave < 0:
		wave = current_wave
	
	if wave > difficulty_stages.size() - 1:
		printerr("No difficulty for current wave")
		return -1

	#TODO check for infinite recursion
	var sample := difficulty_stages[wave]
	if sample < 1:
		return get_max_enemies_for_wave(wave - 1)
	else:
		return sample


func _on_wave_ended() -> void:
	combat_log.append(current_bounty)


func _on_tree_exiting() -> void:
	print(combat_log)
