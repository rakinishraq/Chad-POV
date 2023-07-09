extends "state.gd"

func update(delta):
	Player.player_gravity(delta)
	if Player.on_floor or Player.position.y > Player.vlatest+Player.voffset*delta: # make into and-gate
		return STATES.IDLE
	return null
