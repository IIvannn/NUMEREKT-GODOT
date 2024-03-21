extends "state.gd"



func enter_state():
	Player.fastFall = Player.gravity_value * 2


func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.jump_input_actuation and Player.jumpsLeft >0:
		return STATES.JUMP
	if Player.is_on_floor():
		return STATES.IDLE
	if Player.dash_input and Player.can_dodge:
		return STATES.DODGE
	if Player.onWall:
		return STATES.SLIDE
	if Input.is_action_just_released("Down"):
		return STATES.FALL
	if Player.is_hit:
		return STATES.HURT
	return null

func exit_state():
	Player.fastFall = 0
