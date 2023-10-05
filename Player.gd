extends CharacterBody2D

@export var base_max_speed:float = 900.0
@export var boost_max_speed:float = 1200.0
@export var base_acceleration:float = 5000.0
@export var boost_acceleration:float = 8000.0
@export var boost_burn_per_second:float = 50.0
@export var boost_restore_per_second:float = 20.0
@export var rotation_angle_scaler:float = 0.3
@export var friction_scaler:float = 5.0

@onready var screen_size = get_viewport_rect().size
@onready var player_half_size = get_bounds($ShipCollision)/2
@onready var boost_value:float = 100.0
@onready var boost_bar:ProgressBar = $"../UI/BoostContainer/BoostBar"

func _ready():
	pass

func _physics_process(delta):
	# handle input
	var movement_vector = Input.get_vector("left", "right", "up", "down")
	var acceleration = base_acceleration
	var max_speed = base_max_speed
	if Input.is_action_just_pressed("fire_primary"):
		# fire projectile
		print(boost_bar.value)
	if Input.is_action_pressed("boost") and boost_value > boost_burn_per_second * delta:
		acceleration = boost_acceleration
		max_speed = boost_max_speed
		boost_value -= boost_burn_per_second * delta
	else:
		# recharge boost
		boost_value += boost_restore_per_second * delta
	boost_value = clamp(boost_value, 0.0, 100.0)
	# need to make this a signal later
	boost_bar.value = boost_value
	
	# update velocity, apply friction first then acceleration
	velocity = velocity.lerp(Vector2.ZERO, delta*friction_scaler)
	velocity = velocity.lerp(movement_vector * acceleration, delta)
	if velocity.length() > max_speed:
		# lerp current speed to max speed, allows going over max but smooths
		# the sudden deceleration when you release boost
		velocity = velocity.normalized() * lerp(velocity.length(), max_speed, 0.4)
		#velocity = velocity.normalized() * max_speed
	# keep player on screen
	var new_position = Vector2(
		clamp(position.x, player_half_size.x, screen_size.x-player_half_size.x),
		clamp(position.y, player_half_size.y, screen_size.y-player_half_size.y)
	)
	if position.x != new_position.x:
		velocity.x = 0.0
		position.x = new_position.x
	if position.y != new_position.y:
		velocity.y = 0.0
		position.y = new_position.y
	# rotate ship to match travel direction
	rotation = velocity.y / max_speed * rotation_angle_scaler
	# execute motion
	move_and_slide()

func get_bounds(collision: CollisionPolygon2D):
	var lower = Vector2.INF
	var upper = -Vector2.INF
	for p in collision.polygon:
		lower.x = min(lower.x, p.x)
		lower.y = min(lower.y, p.y)
		upper.x = max(upper.x, p.x)
		upper.y = max(upper.y, p.y)
	return upper - lower
