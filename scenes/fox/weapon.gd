class_name Weapon extends Node2D

signal reloaded
signal activated

enum FiringMode{
	SINGLE,
	BURST,
	AUTOMATIC,
}

@export var base_damage: int = 100
@export var base_knockback: float = 10.0
@export var damage_per_upgrade: int = 15
@export var firing_mode: FiringMode = FiringMode.SINGLE
@export var magazine_size: int = -1
## The firing rate in rounds per minute.
@export_range(100, 2000, 100, "suffix:rpm") var fire_rate: int = 1500
@export var reload_time: float = 1.0
@export var optimal_range: float = 100.0
@export_range(0.0, 1.0) var critical_hit_chance: float = 0.10


@export var tracer_height_variance: float = 4.0


var _rounds: int = 0

@onready var ray_cast: RayCast2D = $RayCast2D
@onready var refire_timer: Timer = $RefireTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	reload()

## Attempts to activate the weapon. Returns true if successful, false if not.
func activate() -> bool:
	if refire_timer.time_left > 0:
		return false
	
	# Purely visual randomization of bullet tracer
	var tracer_end_point := to_global(ray_cast.target_position)
	var height_modifier: float = randf_range(-tracer_height_variance, tracer_height_variance)
	tracer_end_point.y += height_modifier

	if ray_cast.is_colliding():
		var collider := ray_cast.get_collider()
	
		if collider is HurtBox2D:
			tracer_end_point.x = collider.global_position.x
			var damage_data := DamageData.new()
			var inventory: Inventory = Main.get_node("GameState/Inventory")
			damage_data.amount = base_damage + (inventory.upgrades[&"damage"] * damage_per_upgrade)
			damage_data.direction = Vector2.RIGHT if ray_cast.target_position.x > 0 else Vector2.LEFT
			damage_data.knockback = base_knockback
			collider.take_damage(damage_data)
			# print("Damage: ", damage_data.amount)
			# print("Knockback: ", damage_data.knockback)
			
	_draw_tracer(tracer_end_point)
	var refire_delay: float = 60.0 / fire_rate
	refire_timer.start(refire_delay)

	activated.emit()
	return true


func _draw_tracer(end_point: Vector2) -> void:
	var bullet_tracer := Line2D.new()
	
	bullet_tracer.default_color = Color.YELLOW
	bullet_tracer.width = 2
	bullet_tracer.clear_points()
	bullet_tracer.add_point($FirePoint.global_position)
	bullet_tracer.add_point(end_point)

	get_parent().add_sibling(bullet_tracer)

	var tween := create_tween()
	tween.tween_property(bullet_tracer, "modulate:a", 0.0, 0.05)
	await tween.finished
	bullet_tracer.queue_free()



func reload() -> void:
	_rounds = magazine_size
	reloaded.emit()
