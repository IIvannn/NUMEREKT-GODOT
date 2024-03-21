extends "state.gd"

var dodge_direction = Vector2.ZERO
@export var dodge_duration = 0.2
@onready var DodgeDuration_timer = $"dodge Duration"
var dodging = false
var upNerf = 1

func update(delta):
	if !dodging and Player.onGround == false:
		return STATES.FALL
	elif !dodging and Player.onGround and Player.onWall == false:
		return STATES.IDLE
	if !dodging and Player.onWall:
		return STATES.SLIDE
	return null

func enter_state():
	Player.can_dash = false
	dodging = true
	if Player.movement_input != Vector2.ZERO and Player.movement_input.y <0:
		$"dodge Duration".start(dodge_duration)
		dodge_direction = Vector2.UP
		upNerf = 1.6
	elif Player.movement_input != Vector2.ZERO and Player.movement_input.y >0:
		$"dodge Duration".start(dodge_duration)
		dodge_direction = Vector2.DOWN
	elif Player.movement_input != Vector2.ZERO and Player.movement_input.x >0:
		$"dodge Duration".start(dodge_duration)
		dodge_direction = Vector2.RIGHT
	elif Player.movement_input != Vector2.ZERO and Player.movement_input.x <0:
		$"dodge Duration".start(dodge_duration)
		dodge_direction = Vector2.LEFT
	else:
		$"dodge Duration".start(dodge_duration + 0.2)
		dodge_direction = Vector2.ZERO #Player.last_direction
	Player.velocity = dodge_direction.normalized() * (Player.dodgeSpeed)/upNerf

func exit_state():
	upNerf = 1
	dodging = false




func _on_dodge_duration_timeout():
		dodging = false
