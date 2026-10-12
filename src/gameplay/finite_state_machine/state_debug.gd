extends Label

@export var state_machine: StateMachine

func _ready() -> void:
	state_machine.state_changed.connect(_on_state_changed)
	text = "State Monitor\n"
	text += "Current: %s\n" % state_machine.current_state.name


func _on_state_changed(state_name:String) -> void:
	text = "State Monitor\n"
	text += "Current: %s\n" % state_name
