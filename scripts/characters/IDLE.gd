extends "state.gd"


func update(delta):
	Player.gravity(delta)
	player_movement()
	if Player.velocity.x != 0 and Player.movement_input != Vector2.ZERO:
		return STATES.MOVE
	if Player.jump_input_actuation:
		return STATES.JUMP
	if Player.velocity.y > 0:
		return STATES.FALL
	if Player.dash_input and Player.can_dodge:
		return STATES.DODGE
	if Player.is_hit:
		return STATES.HURT
	return null


func enter_state():
	Player.can_dash = true



func exit_state():
	$"../../AnimationPlayer".play("RESET")
