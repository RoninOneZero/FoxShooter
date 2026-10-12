@icon("res://addons/at-icons/node3d/sword.svg")
class_name HitBox3D extends Area3D

signal hit_landed
# signal world_hit_landed

var damage_data := DamageData.new()

@onready var facing := %Facing as Facing

func _ready() -> void:
	monitorable = false
	monitoring = false

	# body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)


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


func _on_area_entered(hurt_box: Area3D) -> void:
	if damage_data.direction == Vector3.ZERO:
		var hit_direction := global_position.direction_to(hurt_box.global_position)
		if hit_direction.x > 0:
			damage_data.direction = Vector3.RIGHT
		elif hit_direction.x < 0:
			damage_data.direction = Vector3.LEFT
		else:
			damage_data.direction.x = facing.direction.x
			damage_data.direction.z = facing.direction.y

	hurt_box.take_damage(damage_data)
	hit_landed.emit()
	disable()
