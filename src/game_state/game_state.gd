@icon("res://addons/at-icons/node/joystick.svg")
class_name GameState extends Node

var player_node: Fox
var player_health: int = -1


func initialize_game_state() -> void:
    var inventory: Inventory = get_node("Inventory")
    inventory.med_kits = 1
    inventory.mines = 0