extends CharacterBody2D


var friction = 20

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8


func _physics_process(delta):
	if !is_on_floor():
		velocity += Vector2.DOWN * gravity
	else:
		velocity.x = lerpf(velocity.x, 0, friction * delta)
	move_and_slide()


func knockback(forceX : float, forceY : float, duration : float):
	velocity = Vector2(forceX, forceY)
