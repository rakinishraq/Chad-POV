extends "state.gd"

func enter_state():
	Player.get_node("SPRITES/MOVE").frame = 0

func update(delta):
	player_movement()
	
	if Player.movement_input:
		Player.SPRITES.scale = Vector2(sign(Player.movement_input), 1)
	
	if Player.velocity == Vector2.ZERO:
		return STATES.IDLE
	if not Player.is_on_floor():
		return STATES.FALL
	if Player.jump_input:
		return STATES.JUMP
	return null

func exit_state():
	pass
