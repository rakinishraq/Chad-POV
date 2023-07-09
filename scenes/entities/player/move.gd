extends "state.gd"

func update(delta):
	Player.player_gravity(delta)
	player_movement()
	
	if Player.movement_input.x:
		Player.SPRITES.scale = Vector2(sign(Player.movement_input.x), 1)
	
	if Player.velocity == Vector2.ZERO:
		return STATES.IDLE
	if Player.gravity > 0:
		return STATES.FALL
	if Player.jump_input:
		return STATES.JUMP
	return null

func exit_state():
	Player.vlatest = Player.position.y
	Player.voffset = 0
