class_name LandMine extends Area2D

@export var arming_time: float = 1.0

var armed := false

@onready var arming_timer: Timer = $ArmingTimer
@onready var hit_box: HitBox2D = $HitBox2D


func _ready() -> void:
	arm()


func arm() -> void:
	arming_timer.start(arming_time)


func explode() -> void:
	#TODO add delay to detonation so that enemies pile up a bit
	var damage_data := DamageData.new()
	damage_data.amount = 200
	
	hit_box.trigger(damage_data, 0.1)
	print("kaboom!")
	await get_tree().create_timer(0.1).timeout
	queue_free()


func _on_arming_timer_timeout() -> void:
	armed = true
	print("click!")


func _on_body_entered(_body: Node2D) -> void:
	if armed:
		explode()
