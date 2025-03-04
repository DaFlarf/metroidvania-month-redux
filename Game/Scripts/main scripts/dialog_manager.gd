extends Node
class_name DialogManager
@export var dialogLines: Array[String]
@onready var db: Label = get_tree().get_first_node_in_group("db")
@onready var index = 0
@export var SFX: AudioStreamPlayer
@export var selfdestruct: bool
var timerStarted
var timer = 0.3
var isActive: bool
func _process(delta):
	if len(dialogLines) != index and isActive:
		db.get_child(1).text = tr(dialogLines[index]).get_slice(":", 0)
		db.text = tr(dialogLines[index]).get_slice(":", 1)
		if Input.is_action_just_released("interact") and db.visible and timer <= 0:
			nextLine()
			timer = 0.2
	elif isActive:
		deactivate()
	
	if timerStarted:
		timer -= delta

func nextLine():
	index += 1
	SFX.play()

func activate():
	SignalBus.emit_signal("cutscene")
	index = 0
	SFX.play()
	db.visible = true
	timer = 0.2
	timerStarted = true
	isActive = true

func deactivate():
	db.visible = false
	db.text = ""
	isActive = false
	SignalBus.emit_signal("cutscene_over")
	if selfdestruct:
		queue_free()
