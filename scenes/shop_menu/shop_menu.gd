extends Control

"""
ShopItem:
	item_name
	button
	rank
	cost
"""

signal continue_requested

@export var purchasable_upgrades: Array[StringName]

@export var packed_shop_item: PackedScene
@export var cash_label: Label
@export var panel: Panel
@export var shop_item_container: Container


func _ready() -> void:
	update_shop()


func update_shop() -> void:
	var inventory: Inventory = Main.get_node("GameState/Inventory")

	cash_label.text = "Cash: %s" % inventory.cash

	for upgrade in purchasable_upgrades:
		var new_shop_item: ShopItem = packed_shop_item.instantiate()
		shop_item_container.add_child(new_shop_item)

		new_shop_item.set_upgrade(upgrade)
		new_shop_item.set_cost(500)
		new_shop_item.set_rank(1)
		new_shop_item.button.pressed.connect(_on_shop_item_button_pressed.bind(new_shop_item))


		if not inventory.can_afford(new_shop_item.cost):
			new_shop_item.button.disabled = true



func close() -> void:
	panel.process_mode = Node.PROCESS_MODE_DISABLED

	var anim: AnimationPlayer = $AnimationPlayer

	anim.play_backwards("open_phone")
	await anim.animation_finished

	hide()
	panel.process_mode = Node.PROCESS_MODE_INHERIT



func _on_shop_item_button_pressed(shop_item: ShopItem) -> void:
	var inventory: Inventory = Main.get_node("GameState/Inventory")

	if not inventory.can_afford(shop_item.cost):
		return

	inventory.spend_cash(shop_item.cost)

	inventory.upgrades[shop_item.upgrade] = shop_item.rank
	shop_item.set_rank(shop_item.rank + 1)

	cash_label.text = "Cash: %s" % inventory.cash
	_update_shop_item_buttons()

	print(inventory.upgrades)

	
func _update_shop_item_buttons() -> void:
	var inventory: Inventory = Main.get_node("GameState/Inventory")
	
	var shop_items: Array[ShopItem] 
	shop_items.assign(shop_item_container.get_children())

	for shop_item in shop_items:
		shop_item.button.disabled = !inventory.can_afford(shop_item.cost)

# func _on_damage_button_pressed() -> void:
# 	var inventory: Inventory = Main.get_node("GameState/Inventory")
	
# 	inventory.spend_cash(500)
# 	inventory.damage_upgrades += 1

# 	update_shop()


# func _on_critical_chance_button_pressed() -> void:
# 	var inventory: Inventory = Main.get_node("GameState/Inventory")
	
# 	inventory.spend_cash(500)
# 	inventory.critical_chance_upgrades += 1

# 	update_shop()


# func _knock_back_button_pressed() -> void:
# 	var inventory: Inventory = Main.get_node("GameState/Inventory")
	
# 	inventory.spend_cash(500)
# 	inventory.knock_back_upgrades += 1

# 	update_shop()


# func _on_continue_button_button_down() -> void:
# 	await close()
# 	continue_requested.emit()


func _on_visibility_changed() -> void:
	if visible:
		panel.process_mode = PROCESS_MODE_DISABLED
		$AnimationPlayer.play("open_phone")
		await $AnimationPlayer.animation_finished
		panel.process_mode = PROCESS_MODE_INHERIT
