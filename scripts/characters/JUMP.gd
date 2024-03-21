extends "state.gd"


func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.jump_input_actuation and Player.jumpsLeft >0:
		return STATES.JUMP
	if Player.velocity.y >0:
		return STATES.FALL
	if Player.dash_input and Player.can_dodge:
		return STATES.DODGE
	if Player.onWall:
		return STATES.SLIDE
	if Input.is_action_pressed("Down"):
		return STATES.FASTFALL
	if Player.is_hit:
		return STATES.HURT
	return null

func enter_state():
	$"../../AnimationPlayer".play("RESET")
	$"../../AnimationPlayer".play("jump")
	if Player.prev_state == STATES.SLIDE:
		Player.velocity.x = (Player.JUMP_VELOCITY) * 2 * Player.last_direction.x
	if Player.jumpsLeft > 0:
		Player.jumpsLeft -= 1
		Player.velocity.y = Player.JUMP_VELOCITY
