extends CharacterBody2D

@onready var screensize = get_viewport_rect().size
@onready var player_size = $ShipCollision.shape.get_rect().size


var max_speed = 2000
var input_scaler = 5000
var friction_scaler = 0.9

func _ready():
	player_size = Vector2(player_size.y, player_size.x) # need to fix this when we get ship collision to not be stupid

func _physics_process(delta):
	var movement_vector = Input.get_vector("left", "right", "up", "down")
	velocity += movement_vector * input_scaler * delta
	velocity *= friction_scaler
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed
	position.x = clamp(position.x, player_size.x, screensize.x-player_size.x)
	position.y = clamp(position.y, player_size.y, screensize.y-player_size.y)
	if Input.is_action_just_pressed("fire_primary"):
		# fire projectile
		print(player_size)
	move_and_slide()
