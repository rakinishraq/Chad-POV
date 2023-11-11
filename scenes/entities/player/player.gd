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
var on_ladder = 0

func _ready():
	animator = $Animator
	camera = get_parent().get_node("Camera2D")

	var callable = Callable(self, "_on_size_changed")
	get_viewport().connect("size_changed", callable)
	_on_size_changed()

	super._ready()


func _process(delta):
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
	

func _physics_process(delta):
	if position.y > 250:
		position = Vector2(70, 100)
		velocity = Vector2.ZERO
		$DeathSound.play()

	if on_ladder and Input.is_action_pressed(input_jump):
		velocity.y = -100
		velocity.x = 0
		move_and_slide()
	else:
		super._physics_process(delta)


func _on_jumped(is_ground_jump):
	$JumpSound.play()


func _on_size_changed():
	$ROOT/CanvasGroup.material.set_shader_parameter("line_thickness",
		min(5.05 / 1890 * DisplayServer.window_get_size().x,
			5.05 / 1080 * DisplayServer.window_get_size().y)
	)


func _on_ladder_body_entered(body):
	if body == self: on_ladder += 1
func _on_ladder_body_exited(body):
	if body == self: on_ladder -= 1
