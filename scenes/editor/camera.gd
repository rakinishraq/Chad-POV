extends Camera2D

const MIN_ZOOM: float = 0.3
const MAX_ZOOM: float = 1.7
const ZOOM_INCREMENT: float = 0.1
const ZOOM_RATE: float = 8.0
var _target_zoom: float = 1.0

func _physics_process(delta):
	position.x += Input.get_axis("ui_left", "ui_right") * zoom.x * delta
	position.y += Input.get_axis("ui_up", "ui_down") * zoom.y * delta
	zoom = lerp(zoom, _target_zoom * Vector2.ONE, ZOOM_RATE * delta)
	set_physics_process(not is_equal_approx(zoom.x, _target_zoom))


func _input(event):
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_RIGHT:
			position -= event.relative
	elif event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_target_zoom = min(_target_zoom + ZOOM_INCREMENT, MAX_ZOOM)
			set_physics_process(true)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_target_zoom = max(_target_zoom - ZOOM_INCREMENT, MIN_ZOOM)
			set_physics_process(true)
