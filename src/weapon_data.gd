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
@export var firing_mode: FiringMode = FiringMode.SINGLE

@export_group("Base Stats", "base")
@export var base_damage: int = 20
## The firing rate in rounds per minute.
@export_range(10, 2000, 10, "suffix:rpm") var base_fire_rate: int = 1500
@export var base_knockback: float = 20.0
@export var base_critical_chance: float = 0.01
@export var base_critical_damage_modifier: float = 4.0
@export var base_magazine_size: int = -1
@export var base_reload_time: float = 1.0

@export_group("Upgrades")
@export var damage_ranks: Array[int] = []
@export var critical_chance_ranks: Array[int] = []
@export var knockback_ranks: Array[int] = []


func get_damage(rank:int=0) -> int:
	if damage_ranks.is_empty():
		return base_damage
	
	if rank >= 0 and rank < damage_ranks.size():
		return damage_ranks[rank]

	# This means rank was out of range
	return base_damage


func get_critical_chance(rank:int=0) -> float:
	if critical_chance_ranks.is_empty():
		return base_critical_chance
	
	if rank >= 0 and rank < critical_chance_ranks.size():
		return critical_chance_ranks[rank]

	# This means rank was out of range
	return base_critical_chance


func get_knockback(rank:int=0) -> float:
	if knockback_ranks.is_empty():
		return base_knockback
	
	if rank >= 0 and rank < knockback_ranks.size():
		return knockback_ranks[rank]

	# This means rank was out of range
	return base_knockback
	