extends "state.gd"

func enter_state():
	Player.velocity = Vector2.ZERO
	Player.gravity = 0
	Player.on_floor = true

func update(delta):
	#Player.player_gravity(delta)
	if Player.movement_input != 0:
		return STATES.MOVE
	if Player.jump_input:
		return STATES.JUMP
	if Player.gravity > 0:
		return STATES.FALL
	return null

func exit_state():
	pass
