class_name Shop extends Node


@export var attribute_costs: Dictionary[Weapon.WeaponAttribute, Array] = {
	Weapon.WeaponAttribute.DAMAGE: 				[500, 1000, 2000],
	Weapon.WeaponAttribute.CRITICAL_CHANCE: 	[500, 1000, 2000],
	Weapon.WeaponAttribute.KNOCKBACK: 			[500, 1000, 2000],
	#Weapon.WeaponAttribute.DAMAGE: 			[500, 1000, 2000],
	#Weapon.WeaponAttribute.DAMAGE: 			[500, 1000, 2000],
}


func get_available_items() -> Array:
	return attribute_costs.keys()

# @onready var inventory: Inventory = Main.get_node("GameState/Inventory")
