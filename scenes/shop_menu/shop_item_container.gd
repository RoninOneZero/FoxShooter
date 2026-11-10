class_name ShopItemContainer extends HBoxContainer

@export var item_name: String = "item"
@export var item_attribute: Weapon.WeaponAttribute
@export var rank: int = 1
@export var cost: int = 500
@export var button: Button


func set_shop_item(_name: String, _attribute: Weapon.WeaponAttribute, _rank: int, _cost: int) -> void:
	item_name = _name
	item_attribute = _attribute
	rank = _rank
	cost = _cost


	$Name.text = item_name.capitalize()
	$Rank.text = "Rank %s" % rank
	$Cost.text = "Cost: %s" % cost
