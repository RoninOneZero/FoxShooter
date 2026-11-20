@icon("res://addons/at-icons/node/joystick.svg")
class_name GameState extends Node

@export var max_stages: int = 40
@export var round_time: float = 99.0

@export var difficulty_stages: Array[int] = []

func _ready() -> void:
    pass


var player_node: Fox
var player_health: int = -1


func initialize_game_state() -> void:
    var inventory: Inventory = get_node("Inventory")
    inventory.med_kits = 1
    inventory.mines = 0

    var combat: CombatManager = get_node("Combat")
    combat.difficulty_stages = difficulty_stages
    combat.current_wave = 0
