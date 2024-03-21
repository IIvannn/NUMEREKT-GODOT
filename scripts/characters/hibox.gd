extends Area2D
@export var forceX = 2500
@export var forceY = -250
@export var dur = 0.5
@onready var Player = $"../../.."
@onready var body = $"../.."
var face_multiplyer = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if body.scale.x == -1:
		face_multiplyer = -1
	else:
		face_multiplyer = 1


func _on_body_entered(body):
	if body.has_method("knockback") and body.invincible == false:
		body.is_hit = true
		if body.is_hit:
			body.hurt_Timer.start(dur)
		body.knockback(forceX * face_multiplyer, forceY, 2, 0.1, 20)
