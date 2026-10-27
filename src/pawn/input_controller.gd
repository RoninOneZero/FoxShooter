@icon("res://addons/at-icons/node/joypad.svg")
class_name InputController extends Controller

@export var state_machine: StateMachine


func _process(_delta: float) -> void:
    direction.x = Input.get_axis("move_left", "move_right")

    attack_pressed = Input.is_action_pressed("attack")


func _unhandled_input(event: InputEvent) -> void:
    if not state_machine:
        return

    if event.is_action_pressed("attack"):
        state_machine.send_event("attack")

    # if event.is_action_pressed("jump"):
    #     state_machine.send_event("jump")

    # if event.is_action_pressed("crouch"):
    #     state_machine.send_event("crouch")

    # if event.is_action_released("crouch"):
    #     state_machine.send_event("stand")

    if event.is_action_pressed("interact"):
        state_machine.send_event("interact")
    
    get_window().set_input_as_handled()
