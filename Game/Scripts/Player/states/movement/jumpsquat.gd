extends State

#needed for any frame data stuff
var frame = 0

@export 
var shorthop_state: State
@export
var fullhop_state: State
@export
var fall_state: State
@export
var shorthop_time: int #the number of frames jump has to be released before to constitute a short hop
@export
var fullhop_time: int #the number of frames till a fullhop

var try_platfall: bool

func enter():
	if parent.helmet == false:
		animation_name = "jumpsquat(helmetless)"
	else:
		animation_name = "jumpsquat"
	try_platfall = false
	frame = 0
	find_direction()
	update_animation()

func process_physics(delta: float) -> State:
	if !parent.is_on_floor():
		return fall_state
	frame += 1
	if frame > fullhop_time:
		return fullhop_state
	if frame > shorthop_time and !(move_component.wants_jump()):
		return shorthop_state
	parent.move_and_slide()	
	return null

func process_input(event: InputEvent) -> State:
	if Input.is_action_pressed("down") and try_platfall == false:
		try_platfall = true
		parent.position.y += 8
		if !parent.is_on_floor():
			return fall_state
	return null
