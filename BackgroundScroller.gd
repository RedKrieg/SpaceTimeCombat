extends ParallaxBackground

@export var scroll_speed := Vector2(1550.0, 0.0)
@onready var player_ship := $"../PlayerShip"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset -= (player_ship.velocity + scroll_speed) * delta 
