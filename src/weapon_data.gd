class_name WeaponData extends Resource

enum WeaponAttribute{
	DAMAGE,
	KNOCKBACK,
	CRITICAL_CHANCE,
	CRITICAL_BONUS,
	MAGAZINE_SIZE,
	FIRE_RATE,
	RELOAD_TIME,
	STUN_CHANCE,
}

enum FiringMode{
	SINGLE,
	BURST,
	AUTOMATIC,
}

@export var name: StringName = &"Pistol"
@export var damage: int = 20
@export var knockback: float = 20.0
@export var critical_chance: float = 0.01
@export var critical_damage_modifier: float = 4.0

@export var firing_mode: FiringMode = FiringMode.SINGLE
@export var magazine_size: int = -1
## The firing rate in rounds per minute.
@export_range(10, 2000, 10, "suffix:rpm") var fire_rate: int = 1500
@export var reload_time: float = 1.0
