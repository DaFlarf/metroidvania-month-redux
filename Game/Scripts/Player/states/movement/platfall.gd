extends State

@export
var fall_state: State
@export
var time :int = 3
var frame: int = 0

func enter():
	frame = 0
	parent.position.y += 8
	find_direction()
	update_animation()

func process_physics(delta: float) -> State:
	frame += 1
	if frame > time:
		return fall_state
	return null
