extends "state.gd"

func enter_state():
	pass

func update(delta):
	Player.player_gravity(delta)
	if Player.is_on_floor():
		return STATES.IDLE

	return null

func exit_state():
	pass
