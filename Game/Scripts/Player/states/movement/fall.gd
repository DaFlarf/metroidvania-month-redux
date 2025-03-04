extends State

@export
var land_state: State

func enter():
	if parent.helmet == false:
		animation_name = "fall(helmetless)"
	else:
		animation_name = "fall"
	find_direction()
	update_animation()

func process_physics(delta: float) -> State:
	if parent.is_on_floor():
		return land_state
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

func process_input(event: InputEvent) -> State:
	return null
