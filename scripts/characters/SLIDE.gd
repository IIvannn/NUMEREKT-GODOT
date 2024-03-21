extends "state.gd"

var slide_friction = 0.7

func update(delta):
	slide_movement(delta)
	if Player.onWall == false:
		return Player.STATES.FALL
	if Player.jump_input_actuation:
		return STATES.JUMP
	if Player.is_hit:
		return STATES.HURT
	return null

func slide_movement(delta):
	Player.gravity(delta)
	Player.velocity.y *= slide_friction

func enter_state():
	pass
