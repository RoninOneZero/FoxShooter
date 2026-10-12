class_name AIController extends Controller

enum Mood{
    IDLE,
    CHASE,
    REPOSITION,
}

@export var approach_distance: float = 100.0

@export_group("Nodes")
@export var pawn: Pawn2D
@export var target: Node2D
@export var facing: Facing
@export var state_machine: StateMachine

var current_mood := Mood.IDLE

func _ready() -> void:
    face_target()


func _physics_process(delta: float) -> void:
    if target == null:
        current_mood = Mood.IDLE
    else:
        current_mood = Mood.CHASE

    match current_mood:
        Mood.IDLE: _idle_process(delta)
        Mood.CHASE: _chase_process(delta)
        Mood.REPOSITION: _reposition_process(delta)


func face_target() -> void:
    if target == null:
        return

    var facing_direction := _get_linear_direction_to(target.global_position)
    
    facing.set_facing(facing_direction)


func _get_linear_direction_to(_position: Vector2) -> Vector2:
    var _direction := pawn.global_position.direction_to(_position)

    if _direction.x == 0:
        return Vector2.ZERO
    else:
        return Vector2.LEFT if _direction.x < 0.0 else Vector2.RIGHT



func _idle_process(_delta) -> void:
    return


func _chase_process(_delta) -> void:
    var distance := pawn.global_position.distance_to(target.global_position)

    if distance > approach_distance:
        direction = _get_linear_direction_to(target.global_position)
    else:
        face_target()
        direction = Vector2.ZERO



func _reposition_process(_delta) -> void:
    pass

