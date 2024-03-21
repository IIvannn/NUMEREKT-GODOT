extends "state.gd"

var dash_direction = Vector2.ZERO
@export var dash_duration = 0.1
@onready var DashDuration_timer = $"dash Duration"
var dashing = false

func update(delta):
	#Player.gravity(delta)
	if !dashing and Player.onGround == false:
		return STATES.FALL
	elif !dashing and Player.onGround:
		return STATES.IDLE
	if Player.jump_input_actuation and Player.jumpsLeft >0:
		$"../../Timers/speedBoost".start()
		Player.SPEED = 1000
		return STATES.JUMP
	if Player.is_hit:
		return STATES.HURT
	return null

func enter_state():
	$"../../AnimationPlayer".play("dash")
	Player.can_dash = false
	dashing = true
	if Player.onGround == false:
		pass
	$"dash Duration".start(dash_duration)
	if Player.movement_input != Vector2.ZERO:
		dash_direction = Player.movement_input
	else:
		dash_direction = Player.last_direction
	Player.velocity = dash_direction.normalized() * Player.dashSpeed

func exit_state():
	$"../../AnimationPlayer".play("RESET")
	dashing = false


func _on_dash_timer_timeout():
	dashing = false
