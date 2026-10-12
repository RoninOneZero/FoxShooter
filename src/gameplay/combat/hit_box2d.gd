class_name HitBox2D extends Area2D

signal hit_landed

@export var toggled := false

var damage_data := DamageData.new()


func _ready() -> void:
	monitorable = false
	monitoring = false

	area_entered.connect(_on_area_entered)

	if toggled:
		trigger()


func trigger(_damage_data:DamageData=null, time:=-1.0) -> void:
	set_deferred("monitoring", true)
	if _damage_data:
		damage_data = _damage_data
	else:
		damage_data = DamageData.new()

	if time > 0.0:
		await get_tree().create_timer(time).timeout
		disable()


func disable() -> void:
	set_deferred("monitoring", false)
	damage_data = DamageData.new()


func _on_area_entered(hurt_box: HurtBox2D) -> void:
	hurt_box.take_damage(damage_data)
	hit_landed.emit()

	if not toggled:
		disable()
