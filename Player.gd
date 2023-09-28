extends CharacterBody2D

var max_speed = 1000
var input_scaler = 1500
var friction_scaler = 0.95

func _physics_process(delta):
	var movement_vector = Input.get_vector("left", "right", "up", "down")
	velocity += movement_vector * input_scaler * delta
	velocity *= friction_scaler
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	if Input.is_action_just_pressed("fire_primary"):
		# fire projectile
		print("FIRE")
	move_and_slide()
