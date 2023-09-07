extends CharacterBody2D

const SPEED = 150.0
const VSPEED = 100.0
const JUMP_VELOCITY = -300.0
const JUMP_MOVESCALE = 0.5
# var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
const GRAVITY = 980

var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false

var gravity = 0
var prev_velocity = velocity

var current_state = null
var prev_state = null
@onready var STATES = $STATES
@onready var SPRITES = $SPRITES


func _ready():
	$SPRITES/MOVE.play("default", 2)
	for state in STATES.get_children():
		state.STATES = STATES
		state.Player = self
	prev_state = STATES.IDLE
	current_state = STATES.IDLE
func _physics_process(delta):
	player_input()
	change_state(current_state.update(delta))
	#$Label.text = str(current_state.get_name())
	move_and_slide()
func player_gravity(delta):
	if not is_on_floor():
		gravity += GRAVITY * delta
		velocity.x = prev_velocity.x * JUMP_MOVESCALE
		velocity.y = gravity + prev_velocity.y * JUMP_MOVESCALE


func change_state(input_state):
	if input_state != null:
		prev_state = current_state
		current_state = input_state
		
		prev_state.exit_state()
		current_state.enter_state()

		SPRITES.get_node(str(prev_state.get_name())).visible = false
		SPRITES.get_node(str(current_state.get_name())).visible = true

func player_input():
	movement_input = 0
	if Input.is_action_pressed("ui_left"):
		movement_input -= 1
	if Input.is_action_pressed("ui_right"):
		movement_input += 1
	
	jump_input = Input.is_action_pressed("ui_accept")
	jump_input_actuation = Input.is_action_just_pressed("ui_accept")
