extends PlatformerController2D

signal leave

var player: int
var input

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const ACCEL = 50.0
const DECEL = 30.0
const AIR_CTRL = 30.0

var animator
var camera

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animator = $Animator
	camera = get_parent().get_node("Camera2D")

func _process(delta):
	# Quit button
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	# Animation
	if abs(velocity).x > 100:
		$ROOT.scale.x = sign(velocity.x)
		$Collision2D.scale.x = sign(velocity.x)
		if is_on_floor():
			if animator.get_current_animation() != "move":
				animator.play("move")
		else:
			animator.play("idle")
	else:
		animator.play("idle")
	
	$ROOT/CanvasGroup.material.set_shader_parameter("line_thickness",
		min(5.0 / 1920 * DisplayServer.window_get_size().x,
			5.0 / 1080 * DisplayServer.window_get_size().y)
	)
