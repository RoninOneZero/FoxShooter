class_name HUD extends Control

@export var health_bar: ProgressBar
@export var kill_count: Label
@export var time_count: Label
@export var wave_count: Label


func set_max_health(amount: int) -> void:
	if health_bar:
		health_bar.max_value = amount


func set_health(amount: int) -> void:
	if health_bar:
		health_bar.value = amount


func set_kill_count(amount: int) -> void:
	var string := "Kills: %02d" % amount
	kill_count.text = string


func set_time(time: float) -> void:
	var string := "Time: %05.2f" % time
	time_count.text = string


func set_wave(amount: int) -> void:
	var string := "Wave: %02d" % amount
	wave_count.text = string