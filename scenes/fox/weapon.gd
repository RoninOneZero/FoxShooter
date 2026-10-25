class_name Weapon extends Node2D

signal reloaded
signal activated
signal failed_to_activate

enum FiringMode{
	SINGLE,
	BURST,
	AUTOMATIC,
}

@export var damage_data: DamageData = DamageData.new()
@export var firing_mode: FiringMode = FiringMode.SINGLE
@export var magazine_size: int = -1
## The firing rate in rounds per minute.
@export_range(100, 2000, 100, "suffix:rpm") var fire_rate: int = 1500
@export var reload_time: float = 1.0
@export var optimal_range: float = 100.0
@export_range(0.0, 1.0) var critical_hit_chance: float = 0.10

var _reload_timer: Timer
var _rounds: int = 0

@onready var ray_cast: RayCast2D = $RayCast2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_reload_timer = Timer.new()
	add_child(_reload_timer)

	reload()


func activate() -> void:
	if _rounds > 0 or magazine_size < 0:
		_rounds -= 1

		if ray_cast.is_colliding():
			var collider := ray_cast.get_collider()
			if collider is HurtBox2D:
				collider.take_damage(damage_data)
				print("Damage: ", damage_data.amount)
		activated.emit()
	else:
		print("No bullets!")
		failed_to_activate.emit()


func reload() -> void:
	_rounds = magazine_size
	reloaded.emit()
