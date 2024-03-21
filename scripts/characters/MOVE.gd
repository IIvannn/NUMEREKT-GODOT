extends "state.gd"


func update(delta):
	$"../../AnimationPlayer".play("walk")
	player_movement()
	Player.gravity(delta)
	if Player.velocity.x == 0:
		return STATES.IDLE
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.jump_input_actuation and Player.jumpsLeft >0:
		return STATES.JUMP
	if Player.dash_input and Player.can_dash:
		return STATES.DASH
	if Player.is_hit:
		return STATES.HURT
	return null
func enter_state():
	Player.can_dash = true
