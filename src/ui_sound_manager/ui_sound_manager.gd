class_name UISoundmanager extends Node

@onready var pressed_audio: AudioStreamPlayer = $ButtonPressed
@onready var selected_audio: AudioStreamPlayer = $ButtonSelected

func _ready() -> void:
    get_tree().node_added.connect(_on_node_added)
    _connect_buttons_in_tree(get_tree().root)


func _on_node_added(node: Node) -> void:
    if node is BaseButton:
        node.pressed.connect(pressed_audio.play)
        node.focus_entered.connect(selected_audio.play)



func _connect_buttons_in_tree(root: Node) -> void:
    for child in root.get_children():
        if child is BaseButton:
            child.pressed.connect(pressed_audio.play)
            child.focus_entered.connect(selected_audio.play)

        _connect_buttons_in_tree(child)