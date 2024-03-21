extends CharacterBody2D

var fric = 1000

var health = 0
var is_hit = false

@export var SPEED = 400.0
var acc = 400
var baseSpeed = null
@export var JUMP_VELOCITY = -400.0
var jumpsLeft = 3
var last_direction = Vector2.RIGHT
var dashSpeed = 2400
var dodgeSpeed = 1000

var gravity_value = 2000
var fastFall = 0

var facingRIGHT = true
var facingLEFT = false

@onready var hurt_Timer = $"Timers/hurt Timer"


@onready var STATES = $STATES

var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false
var dash_input = false

var can_dash = true
var can_dodge = true

var onWall = false
var onGround = false

var current_state = null
var prev_state = null


var invincible = false

var face = null


func _ready():
	for state in STATES.get_children():
		state.STATES = STATES
		state.Player = self
	current_state = STATES.IDLE
	prev_state = STATES.IDLE
	baseSpeed = SPEED
	friction()

func _physics_process(delta):
	
	$"damage Label".modulate = Color(1 - health/700 ,1 - health/300,1 - health/100)
	
	if facingLEFT:
		$body.scale.x = -1
	else:
		$body.scale.x = 1
	
	if is_hit:
		modulate = Color.DARK_GRAY
	else:
		modulate = Color.ALICE_BLUE
	
	if last_direction == Vector2.RIGHT:
		face = 1
		facingRIGHT = true
		facingLEFT = false
	else:
		face = -1
		facingRIGHT = false
		facingLEFT = true
	
	
	player_input()
	change_state(current_state.update(delta))
	
	
	$"State Label".text = str(current_state.get_name())
	$"Prev State Label".text = str(prev_state.get_name())
	$"damage Label".text = str(health, "%")
	
	move_and_slide()
	
	
	if STATES.DODGE.dodging:
		$body/dodge.visible = true
	else:
		$body/dodge.visible = false

func gravity(delta):
	if not is_on_floor():
		velocity.y += (gravity_value + fastFall) * delta


	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func change_state(input_state):
	if input_state != null:
		prev_state = current_state
		current_state = input_state
		
		prev_state.exit_state()
		current_state.enter_state()

func player_input():
	
	#MOVE
	
	movement_input = Vector2.ZERO
	
	if Input.is_action_pressed("Right"):
		movement_input.x += 1
		last_direction = Vector2.RIGHT
	if Input.is_action_pressed("Left"):
		movement_input.x -= 1
		last_direction = Vector2.LEFT
	if Input.is_action_pressed("Down"):
		position.y += 1
		movement_input.y += 1
	if Input.is_action_pressed("Up"):
		movement_input.y -= 1
		
	if Input.is_action_just_pressed("Down"):
		position.y += 1
	
	
	#JUMP
	
	if Input.is_action_pressed("Jump"):
		jump_input = true
	else :
		jump_input = false
	if Input.is_action_just_pressed("Jump"):
		jump_input_actuation = true
	else:
		jump_input_actuation = false
	
	
	#DASH
	
	if Input.is_action_just_pressed("Dash"):
		fric = dashSpeed
		dash_input = true
	else : 
		dash_input = false



func _on_wall_check_body_entered(body):
	jumpsLeft = 3
	onWall = true


func _on_wall_check_body_exited(body):
	onWall = false


func _on_speed_boost_timeout():
	SPEED = baseSpeed


func _on_ground_check_body_entered(body):
	jumpsLeft = 3
	onGround = true


func _on_ground_check_body_exited(body):
	onGround = false

func friction():
#	var fric  = SPEED
	if fric >= 1:
		$"Timers/accel Timer".start()
		fric -= 25

func _on_accel_timer_timeout():
	friction()


func knockback(forceX : float, forceY : float, variable_force : float, duration : float, damage : float):
	if is_hit:
		$"Timers/hurt Timer".start(duration)
		velocity = Vector2(forceX, forceY)

func _on_hurt_timer_timeout():
	is_hit = false


func _on_hurtbox_area_entered(area):
	invincible = true
	$Timers/invTimer.start(0.3)

func _on_inv_timer_timeout():
	invincible = false
