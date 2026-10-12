extends Node2D

signal reloaded
signal activated
signal failed_to_activate

enum FiringMode{
	SINGLE,
	BURST,
	AUTOMATIC,
}

@export var damage: int = 10
@export var firing_mode: FiringMode = FiringMode.SINGLE
@export var magazine_size: int = 10
## The firing rate in rounds per minute.
@export_range(100, 2000, 100, "suffix:rpm") var fire_rate: int = 1500
@export var reload_time: float = 1.0
@export var optimal_range: float = 100.0
@export_range(0.0, 1.0) var critical_hit_change: float = 0.10

var _reload_timer: Timer
var _rounds: int = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_reload_timer = Timer.new()
	add_child(_reload_timer)

	reload()


func activate() -> void:
	if _rounds > 0:
		_rounds -= 1
		activated.emit()
	else:
		failed_to_activate.emit()


func reload() -> void:
	_rounds = magazine_size
	reloaded.emit()