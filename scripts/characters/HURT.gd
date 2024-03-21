extends "state.gd"

var attacking = false


func update(delta):
	if Player.is_hit == false and Player.onGround:
		return STATES.IDLE
	elif Player.is_hit == false and Player.onGround == false:
		return STATES.FALL
	return null

func enter_state():
	pass

func exit_state():
	Player.velocity = Vector2.ZERO

