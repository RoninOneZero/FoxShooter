class_name Fox extends Pawn2D

@export var facing: Facing

func _physics_process(delta: float) -> void:
	super(delta)
	if input_direction and facing:
		facing.set_facing(input_direction)
