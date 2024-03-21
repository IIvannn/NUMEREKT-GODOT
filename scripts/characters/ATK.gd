extends "state.gd"

var attacking = false


func update(delta):
	if !attacking and Player.onGround:
		return STATES.IDLE
	if !attacking and Player.onGround == false:
		return STATES.FALL
	if Player.is_hit:
		return STATES.HURT
	return null

func enter_state():
	pass

func exit_state():
	pass

