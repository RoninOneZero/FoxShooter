@icon("res://addons/at-icons/node/chest.svg")
class_name Inventory extends Node

signal med_kits_changed(amount: int)
signal mines_changed(amount: int)

const MAX_MED_KITS := 3

@export var current_weapon_base: WeaponData
@export var weapon: WeaponData
@export var starting_cash := 0
@export var cash_per_bounty := 50

## Contains upgrade name as a string as keys, and the number of purchased upgrades as values.
var upgrades: Dictionary[WeaponData.WeaponAttribute, int] = {}
var med_kits: int = 1
var mines: int = 1 : 
	set(x): 
		mines = x
		mines_changed.emit(mines)

@onready var cash := starting_cash

func add_cash_from_bounty(bounty_value: int) -> void:
	var cash_to_add := cash_per_bounty * bounty_value
	cash += cash_to_add
	print("Cash awarded: %s | Total: %s" % [cash_to_add, cash])


func can_afford(amount: int) -> bool:
	var cash_difference := cash - amount
	return true if cash_difference >= 0 else false


func spend_cash(amount: int):
	if can_afford(amount):
		cash -= amount


func get_upgraded_weapon_data() -> WeaponData:
	var upgraded_weapon_data := current_weapon_base

	return upgraded_weapon_data


func use_med_kit() -> void:
	if med_kits - 1 >= 0:
		med_kits -= 1
		med_kits_changed.emit(med_kits)


func add_med_kit () -> void:
	if med_kits + 1 <= MAX_MED_KITS:
		med_kits += 1
		med_kits_changed.emit(med_kits)



