@icon("res://addons/at-icons/node/cog.svg")
@abstract
class_name State extends Node

@warning_ignore("unused_signal")
signal state_switched(state: State)
@warning_ignore("unused_signal")
signal entered

@export var enabled := true

var is_active := false
var state_machine: StateMachine


func enter() -> void:
    pass


func exit() -> void:
    pass


func update(_delta: float) -> void:
    pass


func physics_update(_delta: float) -> void:
    pass


func receive_event(_event: String) -> void:
    pass