extends "state.gd"

func enter_state():
	Player.on_floor = false

func update(delta):
	Player.player_gravity(delta)
	if Player.position.y > Player.vlatest+Player.voffset*delta: # make into and-gate
		if Player.in_floor:
			return STATES.IDLE
		else:
			Player.set_collision_mask_value(2, false) # dead

	return null

func exit_state():
	Player.on_floor = true
