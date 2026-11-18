class_name Shop extends Node

enum Consumable {
	MED_KIT,
	LAND_MINE,
}

@export var attribute_costs: Dictionary[WeaponData.WeaponAttribute, Array] = {
	WeaponData.WeaponAttribute.DAMAGE: 				[500, 1000, 2000],
	WeaponData.WeaponAttribute.CRITICAL_CHANCE: 	[500, 1000, 2000],
	WeaponData.WeaponAttribute.KNOCKBACK: 			[500, 1000, 2000],
	#WeaponData.WeaponAttribute.DAMAGE: 			[500, 1000, 2000],
	#WeaponData.WeaponAttribute.DAMAGE: 			[500, 1000, 2000],
}

@export var consumable_costs: Dictionary [Consumable, int] = {
	Consumable.MED_KIT: 100,
	Consumable.LAND_MINE: 500,
}


func get_available_upgrades() -> Array:
	return attribute_costs.keys()


func get_available_consumabled() -> Array:
	return consumable_costs.keys()