@icon("res://addons/at-icons/node/chest.svg")
class_name Inventory extends Node

const BASE_DAMAGE = 1

@export var starting_cash := 0
@export var cash_per_bounty := 50

## Contains upgrade name as a string as keys, and the number of purchased upgrades as values.
var upgrades: Dictionary[StringName, int] = {
    "damage": 0,
    "critical_chance": 0,
    "knockback": 0,
}


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

