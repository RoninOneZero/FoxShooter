class_name Weapon extends Node2D

signal reloaded
signal activated

enum FiringMode{
	SINGLE,
	BURST,
	AUTOMATIC,
}

enum WeaponAttribute{
	DAMAGE,
	KNOCKBACK,
	CRITICAL_CHANCE,
	CRITICAL_BONUS,
	MAGAZINE_SIZE,
	FIRE_RATE,
	RELOAD_TIME,
	STUN,
}


@export var data: WeaponData
@export var tracer_height_variance: float = 4.0

@export var crit_animation: AnimationPlayer


var _rounds: int = 0

@onready var ray_cast: RayCast2D = $RayCast2D
@onready var refire_timer: Timer = $RefireTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reload()


func can_activate() -> bool:
	return refire_timer.time_left <= 0

## Attempts to activate the weapon. Returns true if successful, false if not.
func activate() -> bool:
	if not can_activate():
		return false
	
	# Purely visual randomization of bullet tracer
	var tracer_end_point := to_global(ray_cast.target_position)
	var height_modifier: float = randf_range(-tracer_height_variance, tracer_height_variance)
	tracer_end_point.y += height_modifier

	if ray_cast.is_colliding():
		var collider := ray_cast.get_collider()
	
		if collider is HurtBox2D:
			tracer_end_point.x = collider.global_position.x

			collider.take_damage(_get_damage_data())
			# print("Damage: ", damage_data.amount)
			# print("Knockback: ", damage_data.knockback)
			
	_draw_tracer(tracer_end_point)
	var refire_delay: float = 60.0 / data.fire_rate
	refire_timer.start(refire_delay)

	activated.emit()
	return true

func _get_damage_data() -> DamageData:
	var damage_data := DamageData.new()

	# Roll for crit
	var damage := data.damage
	var modified_crit = data.critical_chance
	if randf() <= modified_crit:
		damage = floor(damage * data.critical_damage_modifier)
		crit_animation.play("crit")
		print("Crit!")

	damage_data.amount = damage

	
	damage_data.direction = Vector2.RIGHT if scale.x > 0 else Vector2.LEFT
	
	
	damage_data.knockback = data.knockback

	return damage_data


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
	_rounds = data.magazine_size
	reloaded.emit()
