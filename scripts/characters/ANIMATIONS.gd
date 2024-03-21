extends Node

@onready var Player = $".."
@export var recinpulseY = -700
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	if Input.is_action_just_pressed("LightATK") and Player.movement_input == Vector2.ZERO:
		$"../AnimationPlayer".play("nlight")
	if Input.is_action_just_pressed("LightATK") and Input.is_action_pressed("Down"):
		$"../AnimationPlayer".play("dlight")
	if Input.is_action_just_pressed("HeavyATK") and Player.movement_input == Vector2.ZERO:
		Player.velocity.y = recinpulseY
		$"../AnimationPlayer".play("recovery")
