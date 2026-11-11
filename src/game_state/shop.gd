class_name Shop extends Node


@export var attribute_costs: Dictionary[WeaponData.WeaponAttribute, Array] = {
	WeaponData.WeaponAttribute.DAMAGE: 				[500, 1000, 2000],
	WeaponData.WeaponAttribute.CRITICAL_CHANCE: 	[500, 1000, 2000],
	WeaponData.WeaponAttribute.KNOCKBACK: 			[500, 1000, 2000],
	#WeaponData.WeaponAttribute.DAMAGE: 			[500, 1000, 2000],
	#WeaponData.WeaponAttribute.DAMAGE: 			[500, 1000, 2000],
}


func get_available_items() -> Array:
	return attribute_costs.keys()

# @onready var inventory: Inventory = Main.get_node("GameState/Inventory")
