extends "state.gd"

func enter_state():
	Player.gravity = Player.JUMP_VELOCITY
	Player.prev_velocity = Player.velocity

func update(delta):
	Player.player_gravity(delta)
	if Player.gravity > 0:
		return STATES.FALL
	return null
