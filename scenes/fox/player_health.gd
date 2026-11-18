class_name PlayerHealth extends Health

signal med_kit_used
signal med_kit_failed

@export var med_kit_cooldown: Timer

var med_kit_ready := true

@onready var inventory: Inventory = Main.get_node("GameState/Inventory")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use_item") and med_kit_ready:
		use_med_kit()


func heal() -> void:
	current_health = max_health
	#TODO make this lerp upward till full or damage taken



func use_med_kit() -> void:
	if inventory.med_kits > 0 and current_health < max_health:
		inventory.use_med_kit()

		heal()
		
		med_kit_used.emit()
		med_kit_ready = false
		med_kit_cooldown.start()
	else:
		med_kit_failed.emit()


func _on_timer_timeout() -> void:
	med_kit_ready = true
