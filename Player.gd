extends CharacterBody2D

@onready var screen_size = get_viewport_rect().size
@onready var player_half_size = get_bounds($ShipCollision)/2

var max_speed = 2000
var input_scaler = 5000
var friction_scaler = 0.9

func _ready():
	pass

func _physics_process(delta):
	var movement_vector = Input.get_vector("left", "right", "up", "down")
	velocity += movement_vector * input_scaler * delta
	velocity *= friction_scaler
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
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
	if Input.is_action_just_pressed("fire_primary"):
		# fire projectile
		print(player_half_size)
	move_and_slide()

func get_bounds(collision: CollisionPolygon2D):
	var lower = Vector2.INF
	var upper = -Vector2.INF
	for p in collision.polygon:
		if p.x < lower.x:
			lower.x = p.x
		if p.y < lower.y:
			lower.y = p.y
		if p.x > upper.x:
			upper.x = p.x
		if p.y > upper.y:
			upper.y = p.y
	return upper - lower
