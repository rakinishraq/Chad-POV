extends PlatformerController2D

signal leave

var player: int
var input
var spawn

const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const ACCEL = 50.0
const DECEL = 30.0
const AIR_CTRL = 30.0

var animator

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var on_ladder = 0

var pressed = false
@onready var editor = get_parent().get_name() != "LevelHost"

func _ready():
	spawn = position
	animator = $Animator

	var callable = Callable(self, "_on_size_changed")
	get_viewport().connect("size_changed", callable)
	_on_size_changed()

	super._ready()


func _input(event):
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

	if event is InputEventMouseMotion and editor and pressed:
			position += event.relative
	

func _physics_process(delta):
	if editor:
		return

	# Death
	if position.y > 250:
		position = spawn
		velocity = Vector2.ZERO
		$DeathSound.play()

	# Ladder
	if on_ladder and Input.is_action_pressed(input_jump):
		velocity.y = -100
		velocity.x = 0
		move_and_slide()
	else:
		# Default PlatformerController2D
		super._physics_process(delta)


func _on_jumped(_is_ground_jump):
	$JumpSound.play()


func _on_size_changed():
	$ROOT/CanvasGroup.material.set_shader_parameter("line_thickness",
		GameState.outline_size
	)


func _on_ladder_body_entered(body):
	if body == self: on_ladder += 1
func _on_ladder_body_exited(body):
	if body == self: on_ladder -= 1


func _on_button_button_up():
	pressed = false
func _on_button_button_down():
	pressed = true
