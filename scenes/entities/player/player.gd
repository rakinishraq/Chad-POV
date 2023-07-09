extends CharacterBody2D

const SPEED = 200.0
const VSPEED = 100.0
const JUMP_VELOCITY = -300.0
const JUMP_MOVESCALE = 0.5
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false

var gravity = 0
var on_floor = true
var prev_velocity = velocity
var vlatest = position.y
var voffset = 0

var current_state = null
var prev_state = null
@onready var STATES = $STATES
@onready var SPRITES = $SPRITES


func _ready():
	for state in STATES.get_children():
		state.STATES = STATES
		state.Player = self
	prev_state = STATES.IDLE
	current_state = STATES.IDLE
func _physics_process(delta):
	player_input()
	change_state(current_state.update(delta))
	$Label.text = str(current_state.get_name())
	move_and_slide()
	#default_move(delta)
func player_gravity(delta):
	if not on_floor:
		gravity += GRAVITY * delta
		velocity.x = prev_velocity.x * JUMP_MOVESCALE
		velocity.y = gravity + prev_velocity.y * JUMP_MOVESCALE
		voffset += prev_velocity.y * JUMP_MOVESCALE

func default_move(delta):
	if on_floor:
		if Input.is_action_just_pressed("ui_accept"):
			on_floor = false
			gravity += JUMP_VELOCITY
		
		var direction_x = Input.get_axis("ui_left", "ui_right")
		if direction_x:
			velocity.x = direction_x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
		var direction_y = Input.get_axis("ui_up", "ui_down")
		if direction_y:
			velocity.y = direction_y * VSPEED
		else:
			velocity.y = move_toward(velocity.y, 0, VSPEED)
	else:
		gravity += GRAVITY * delta
		#on_floor = true
		velocity.y = gravity

	move_and_slide()

func change_state(input_state):
	if input_state != null:
		prev_state = current_state
		current_state = input_state
		
		prev_state.exit_state()
		current_state.enter_state()

		SPRITES.get_node(str(prev_state.get_name())).visible = false
		SPRITES.get_node(str(current_state.get_name())).visible = true

func player_input():
	movement_input = Vector2.ZERO
	if Input.is_action_pressed("ui_left"):
		movement_input.x -= 1
	if Input.is_action_pressed("ui_right"):
		movement_input.x += 1
	if Input.is_action_pressed("ui_up"):
		movement_input.y -= 1
	if Input.is_action_pressed("ui_down"):
		movement_input.y += 1
	
	jump_input = Input.is_action_pressed("ui_accept")
	jump_input_actuation = Input.is_action_just_pressed("ui_accept")
