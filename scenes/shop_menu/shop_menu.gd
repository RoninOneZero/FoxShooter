extends Control

signal continue_requested


@export var packed_shop_item: PackedScene
@export var cash_label: Label
@export var panel: Panel
@export var shop_item_container: Container
@export var continue_button: Button

@onready var shop: Shop = Main.get_node("GameState/Shop")
@onready var inventory: Inventory = Main.get_node("GameState/Inventory")


func initalize_shop() -> void:
	cash_label.text = "Cash: %s" % inventory.cash

	var available_items = shop.get_available_items()

	if available_items.is_empty():
		print("Shop has no available items!")
		return

	var current_items := shop_item_container.get_children()
	for item in current_items:
		item.queue_free()


	for item in available_items:
		
		var item_name := ""

		match item:
			WeaponData.WeaponAttribute.DAMAGE: item_name = "Damage"
			WeaponData.WeaponAttribute.CRITICAL_CHANCE: item_name = "Crit Chance"
			WeaponData.WeaponAttribute.KNOCKBACK: item_name = "Knockback"

		var item_attribute: WeaponData.WeaponAttribute = item
		var item_rank: int = inventory.upgrades.get_or_add(item, 0) + 1

		if not (item_rank < shop.attribute_costs[item].size()):
			continue


		var item_cost: int = shop.attribute_costs[item][item_rank]

		var new_shop_item: ShopItemContainer = packed_shop_item.instantiate()
		shop_item_container.add_child(new_shop_item)
		new_shop_item.set_shop_item(item_name, item_attribute, item_rank, item_cost)
		new_shop_item.button.pressed.connect(_on_shop_item_button_pressed.bind(new_shop_item))

		if not inventory.can_afford(item_cost):
			new_shop_item.button.disabled = true


func buy_item(shop_item: ShopItemContainer) -> void:
	if not inventory.can_afford(shop_item.cost):
		return

	inventory.spend_cash(shop_item.cost)
	inventory.upgrades[shop_item.item_attribute] = shop_item.rank

	initalize_shop()


func close() -> void:
	panel.process_mode = Node.PROCESS_MODE_DISABLED

	_remove_effect_from_music()
	var anim: AnimationPlayer = $AnimationPlayer

	anim.play_backwards("open_phone")
	await anim.animation_finished

	hide()
	panel.process_mode = Node.PROCESS_MODE_INHERIT



func select_continue_button() -> void:
	if visible:
		continue_button.grab_focus.call_deferred()


func _add_effect_to_music() -> void:
	var music_index := AudioServer.get_bus_index("Music")
	AudioServer.set_bus_effect_enabled(music_index, 0, true)


func _remove_effect_from_music() -> void:
	var music_index := AudioServer.get_bus_index("Music")
	AudioServer.set_bus_effect_enabled(music_index, 0, false)



func _on_shop_item_button_pressed(shop_item: ShopItemContainer) -> void:
	buy_item(shop_item)


func _on_continue_button_button_down() -> void:
	await close()
	continue_requested.emit()


func _on_visibility_changed() -> void:
	if visible:
		initalize_shop()
		panel.process_mode = PROCESS_MODE_DISABLED
		_add_effect_to_music()
		$AnimationPlayer.play("open_phone")
		await $AnimationPlayer.animation_finished
		panel.process_mode = PROCESS_MODE_INHERIT
