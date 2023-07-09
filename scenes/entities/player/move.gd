extends "state.gd"

func enter_state():
	Player.get_node("SPRITES/MOVE").frame = 0

func update(delta):
	player_movement()
	
	if Player.movement_input.x:
		Player.SPRITES.scale = Vector2(sign(Player.movement_input.x), 1)
	
	if Player.velocity == Vector2.ZERO:
		return STATES.IDLE
	if not Player.in_floor:
		Player.set_collision_mask_value(2, false) # dead
		return STATES.FALL
	if Player.jump_input:
		return STATES.JUMP
	return null

func exit_state():
	Player.vlatest = Player.position.y
	Player.voffset = 0
