extends State

@export 
var walk_state: State
@export
var jumpsquat_state: State
@export
var fall_state: State

@export
var traction: int = 20

func enter():
	if parent.helmet == false:
		animation_name = "idle(helmetless)"
	else:
		animation_name = "idle"
	find_direction()
	update_animation()

func process_physics(delta: float) -> State:
	
	#check player speed
	var current_speed = abs(parent.velocity.length())
	var movement = get_movement_input() 
	movement = movement.normalized()
	
	#if the player is touching the joystick
	if movement.x != 0:
		return walk_state
		
	if !parent.is_on_floor():
		return fall_state
		
	#slow the heck down
	if current_speed > 0: 
		current_speed -= traction
		parent.velocity = movement * current_speed
	return null

func process_input(event: InputEvent) -> State:
	if(move_component.wants_jump()):
		return jumpsquat_state
	return null
