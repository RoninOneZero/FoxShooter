class_name ShopItem extends HBoxContainer

@export var upgrade: StringName = "damage"
@export var rank: int = 1
@export var cost: int = 500
@export var button: Button


func set_upgrade(value: StringName) -> void:
    upgrade = value
    $Name.text = upgrade.capitalize()


func set_rank(value: int) -> void:
    rank = value
    $Rank.text = "Rank %s" % rank

    set_cost(rank * 500)


func set_cost(value: int) -> void:
    cost = value
    $Cost.text = "Cost: %s" % cost