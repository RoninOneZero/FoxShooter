class_name Fox extends Pawn2D

@export var mine_packed_scene: PackedScene


@onready var facing: Facing = $Facing
@onready var state_machine: StateMachine = $StateMachine
@onready var floor_ray_cast: RayCast2D = $FloorRayCast

@onready var inventory: Inventory = Main.get_node("GameState/Inventory")

func _physics_process(delta: float) -> void:
	super(delta)
	if input_direction and facing:
		facing.set_facing(input_direction)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("plant_mine"):
		if inventory.mines <= 0:
			return

		if not floor_ray_cast.is_colliding():
			return

		inventory.mines -= 1
		
		var new_mine: LandMine = mine_packed_scene.instantiate()
		add_sibling(new_mine)

		new_mine.global_position = floor_ray_cast.get_collision_point()
		new_mine.arm()
		

		


func _on_hurt_box_2d_damage_taken(data: DamageData) -> void:
	var health: Health = get_node("Health")
	health.current_health -= data.amount
	
	$AnimationPlayer.play("invulnerability")
	state_machine.change_state("hurt_state")
	


func _on_invulnerability_timer_timeout() -> void:
	$HurtBox2D.enabled = true
	$AnimationPlayer.play("RESET")
