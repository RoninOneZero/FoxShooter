@icon("res://addons/at-icons/node/head_with_gear.svg")
class_name StateMachine extends Node

signal state_changed(state_name:String)

@export var initial_state: State

var current_state : State
var previous_state: State

var _states : Dictionary = {}


func _ready() -> void:
	for child in get_children():
		if child is State:
			_states[child.name.to_lower()] = child
			child.state_machine = self

	if initial_state:
		current_state = initial_state
		initial_state.enter()
		initial_state.is_active = true


func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


## Sends an event down to the current state for internal handling
func send_event(event:String) -> void:
	if current_state:
		current_state.receive_event(event)


## Attempts to transition to the state by name if it exists and is enabled
func change_state(new_state_name:String, force_re_entry:bool=false) -> void:
	var key = new_state_name.to_lower()
	key = key.replace("_", "")

	if not _states.has(key):
		print("State does not exist: ", new_state_name)
		return

	if not _states[key].enabled:
		return

	if current_state.name.to_lower() == key and not force_re_entry:
		print("Attemped invalid re-entry of state: ", new_state_name)
		return

	if current_state:
		current_state.exit()
		current_state.is_active = false

	previous_state = current_state
	current_state = _states[key]
	current_state.enter()
	current_state.is_active = true
	current_state.entered.emit()

	state_changed.emit(new_state_name)
