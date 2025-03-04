extends State

@export
var time: int
@export
var fall_state: State
@export
var landing_state: State
@export
var not_so_full_hop_time: int

var frame = 0

func enter() -> void:
	if parent.helmet == false:
		animation_name = "jump(helmetless)"
	else:
		animation_name = "jump"
	frame = 0
	parent.velocity.y = parent.JUMP_VELOCITY
	find_direction()
	update_animation()

func process_physics(delta: float) -> State:
	frame += 1
	if frame > time:
		return fall_state
	if frame > not_so_full_hop_time and !move_component.wants_jump():
		return fall_state
	if parent.is_on_floor() and frame > 6:
		return landing_state
	
	find_direction()
	var movement = get_movement_input() 
	movement = movement.normalized()
	if movement.x > 0:
		movement.x = 1
	if movement.x < 0:
		movement.x = -1
	parent.velocity.x = movement.x * move_speed
	parent.velocity.y = min(parent.velocity.y + parent.gravity * delta, parent.MAX_FALL_SPEED)
	parent.move_and_slide()
	return null

#implement double jump later
func process_input(event: InputEvent) -> State:
	#if !(move_component.wants_jump()):
		#return fall_state
	return null
