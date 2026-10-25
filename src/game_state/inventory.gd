@icon("res://addons/at-icons/node/chest.svg")
class_name Inventory extends Node

const BASE_DAMAGE = 1

@export var starting_cash := 0
@export var cash_per_bounty := 50


var damage_upgrades := 0
var critical_chance_upgrades := 0
var knock_back_upgrades := 0

@onready var cash := starting_cash

func add_cash_from_bounty(bounty_value: int) -> void:
    cash += cash_per_bounty * bounty_value


func can_afford(amount: int) -> bool:
    var cash_difference := cash - amount
    return true if cash_difference >= 0 else false


func spend_cash(amount: int):
    if can_afford(amount):
        cash -= amount


func get_damage_data() -> DamageData:
    var damage_data := DamageData.new()

    damage_data.amount = BASE_DAMAGE + (damage_upgrades * 1)

    return damage_data