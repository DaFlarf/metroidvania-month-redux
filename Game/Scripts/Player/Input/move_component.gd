class_name Move_component
extends Node

var movement_dir: Vector2
@onready var parent: Player = $".."

func get_movement_direction() -> Vector2:
	movement_dir.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	movement_dir.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	return movement_dir
	
#uses is_action_pressed() for negative edge shenanigans to determine short/full hop
func wants_jump() -> bool:
	if (Input.is_action_pressed("jump")):
		return true
	return false
