extends Control

signal continue_requested

@export var cash_label: Label
@export var panel: Panel

@export var damage_button: Button
@export var critical_chance_button: Button
@export var knock_back_button: Button

@export var damage_rank_counter: Label
@export var critical_chance_rank_counter: Label
@export var knock_back_rank_counter: Label


func _ready() -> void:
	damage_button.pressed.connect(_on_damage_button_pressed)
	critical_chance_button.pressed.connect(_on_critical_chance_button_pressed)
	knock_back_button.pressed.connect(_knock_back_button_pressed)


	update_shop()


func update_shop() -> void:
	var inventory: Inventory = Main.get_node("GameState/Inventory")

	cash_label.text = "Cash: %s" % inventory.cash

	damage_rank_counter.text = "Rank %s" % (inventory.damage_upgrades + 1)
	critical_chance_rank_counter.text = "Rank %s" % (inventory.critical_chance_upgrades + 1)
	knock_back_rank_counter.text = "Rank %s" % (inventory.knock_back_upgrades + 1)

	damage_button.disabled = !inventory.can_afford(500)
	critical_chance_button.disabled = !inventory.can_afford(500)
	knock_back_button.disabled = !inventory.can_afford(500)


func close() -> void:
	panel.process_mode = Node.PROCESS_MODE_DISABLED

	var anim: AnimationPlayer = $AnimationPlayer

	anim.play_backwards("open_phone")
	await anim.animation_finished

	hide()
	panel.process_mode = Node.PROCESS_MODE_INHERIT

func _on_damage_button_pressed() -> void:
	var inventory: Inventory = Main.get_node("GameState/Inventory")
	
	inventory.spend_cash(500)
	inventory.damage_upgrades += 1

	update_shop()


func _on_critical_chance_button_pressed() -> void:
	var inventory: Inventory = Main.get_node("GameState/Inventory")
	
	inventory.spend_cash(500)
	inventory.critical_chance_upgrades += 1

	update_shop()


func _knock_back_button_pressed() -> void:
	var inventory: Inventory = Main.get_node("GameState/Inventory")
	
	inventory.spend_cash(500)
	inventory.knock_back_upgrades += 1

	update_shop()


func _on_continue_button_button_down() -> void:
	await close()
	continue_requested.emit()


func _on_visibility_changed() -> void:
	if visible:
		panel.process_mode = PROCESS_MODE_DISABLED
		$AnimationPlayer.play("open_phone")
		await $AnimationPlayer.animation_finished
		panel.process_mode = PROCESS_MODE_INHERIT
