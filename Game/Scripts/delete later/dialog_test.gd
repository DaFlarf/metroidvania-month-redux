extends Node

var activated = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if !activated:
			$"../DialogManager".activate()
			activated = true
		else:
			print("nuh uh")
