class_name SpawnTimer extends Node

signal enemy_requested

@export var max_enemies: int = 2
@export var max_spawn_rate: float = 1.0

var enemies: int = 0

var _time: float = 0.0


func _process(delta: float) -> void:
	_decide(delta)


func _decide(delta: float) -> void:
	_time += delta

	if _time >= _get_spawn_time() and enemies < max_enemies:
		enemy_requested.emit()
		_time = 0.0


func _get_spawn_time() -> float:
	if enemies >= max_enemies:
		return 99999.0

	var fraction := float(enemies) / max_enemies
	fraction = 1.0 - fraction

	var result := max_spawn_rate * fraction
	return result

