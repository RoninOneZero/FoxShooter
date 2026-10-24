class_name HUD extends Control

@export var health_bar: ProgressBar
@export var kill_count: Label

func set_max_health(amount: int) -> void:
	if health_bar:
		health_bar.max_value = amount


func set_health(amount: int) -> void:
	if health_bar:
		health_bar.value = amount


func set_kill_count(amount: int) -> void:
	var string := "Kills: %02d" % amount
	kill_count.text = string
