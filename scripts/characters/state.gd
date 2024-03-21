extends Node

var STATES = null
var Player = null
var ANIMATIONS = null

func _ready():
	pass


func _physics_process(delta):
	pass


func enter_state():
	pass


func exit_state():
	pass


func update(delta):
	return null


func player_movement():
	if Player.movement_input.x >0:
		Player.fric = Player.SPEED
		Player.velocity.x = Player.SPEED
		Player.last_direction = Vector2.RIGHT
	elif Player.velocity.x <0:
		Player.fric = Player.SPEED
		Player.last_direction = Vector2.LEFT
		Player.velocity.x = -Player.SPEED
	elif Player.movement_input.x == 0 and Player.last_direction == Vector2.RIGHT and Player.prev_state == STATES.MOVE and Player.is_hit == false:
		Player.friction()
		Player.velocity.x = Player.fric
	elif Player.movement_input.x == 0 and Player.last_direction == Vector2.LEFT and Player.prev_state == STATES.MOVE and Player.is_hit == false:
		Player.friction()
		Player.velocity.x = -Player.fric
	elif Player.movement_input.x == 0 and Player.last_direction == Vector2.RIGHT and Player.prev_state == STATES.DASH and Player.is_hit == false:
		Player.friction()
		Player.velocity.x = Player.fric
	elif Player.movement_input.x == 0 and Player.last_direction == Vector2.LEFT and Player.prev_state == STATES.DASH and Player.is_hit == false:
		Player.friction()
		Player.velocity.x = -Player.fric
