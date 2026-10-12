extends Node2D

const ENEMIES_GROUP := "Enemies"

@export var player: Pawn2D

func _ready() -> void:
	var enemies := get_tree().get_nodes_in_group(ENEMIES_GROUP)

	for enemy: Pawn2D in enemies:
		var controller := enemy.get_node("AIController") as AIController
		controller.target = player
		controller.face_target()
