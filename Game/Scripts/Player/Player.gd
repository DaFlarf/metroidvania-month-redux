class_name Player
extends CharacterBody2D

#-----------------
#onready variables
#-----------------
@onready
var animations = $animations
@onready
var state_machine = $state_machine
@onready
var move_component = $move_component
@onready
var hurtbox = $Area2D

#----------------
#export variables
#----------------
@export
var JUMP_VELOCITY: int
@export
var SHORT_HOP_MODIFIER: float
@export
var MAX_FALL_SPEED: int
@export
var SHORT_HOP_TIME: int #I want frame based, but I can settle for milisecond based
@export
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity") 


var reset_position: Vector2
# Indicates that the player has an event happening and can't be controlled.
var event: bool

var abilities: Array[StringName]
var prev_on_floor: bool
var airtime: float = 0

var helmet = true

#---------------
#other variables
#---------------
var state_machine_disabled = false

#---------------
#methods
#---------------
func _ready() -> void:
	#set up state machine
	state_machine.init(self, animations, move_component)
	
func _unhandled_input(event: InputEvent) -> void:
	if !state_machine_disabled:
		state_machine.process_input(event)	

func _physics_process(delta: float) -> void:
	if !state_machine_disabled:
		state_machine.process_physics(delta)

func on_enter():
	# Position for kill system. Assigned when entering new room (see Game.gd).
	reset_position = position
