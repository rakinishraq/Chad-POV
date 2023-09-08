extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0
const ACCEL = 50.0
const DECEL = 30.0
const AIR_CTRL = 30.0

var animator

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animator = $Animator

func _physics_process(delta):
	# Quit button
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	# Gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	# Jump
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Horizontal Movement
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		var _ctrl = AIR_CTRL
		if is_on_floor():
			_ctrl = ACCEL
		velocity.x = move_toward(velocity.x, direction * SPEED, _ctrl)
	else:
		velocity.x = move_toward(velocity.x, 0, DECEL * int(is_on_floor()))
	move_and_slide()
	
	# Animation
	if velocity.x != 0:
		$ROOT.scale.x = sign(velocity.x)
		if is_on_floor():
			if animator.get_current_animation() != "move":
				animator.play("move")
		else:
			animator.play("idle")
	else:
		animator.play("idle")
