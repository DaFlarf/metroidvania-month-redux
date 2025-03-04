extends State
@export 
var idle_state: State
@export
var jumpsquat_state: State
@export
var fall_state: State
@export
var traction:= 20


func enter() -> void:
	if parent.helmet == false:
		animation_name = "run(helmetless)"
	else:
		animation_name = "run"
	find_direction()
	update_animation()

func process_physics(delta: float) -> State:
	
	if !parent.is_on_floor():
		return fall_state
	
	#check player speed
	var current_speed = abs(parent.velocity.length())
	var movement = get_movement_input() 
	movement = movement.normalized()
	
	#if you aren't super fast
	if current_speed <= move_speed:
		
		#if you're not moving
		if movement.x == 0:
			return idle_state
			
		else:
			find_direction()
		
		#move those legs
		if movement.x > 0:
			movement.x = 1
		if movement.x < 0:
			movement.x = -1
		parent.velocity.x = movement.x * move_speed
		
	else: #slow the heck down
		current_speed -= traction
		parent.velocity = movement * current_speed
	parent.move_and_slide()
	return null
	
func process_input(event: InputEvent) -> State:
	if(move_component.wants_jump()):
		return jumpsquat_state
	return null
