extends ParallaxBackground

@export var scroll_speed := Vector2(1550.0, 0.0)
@onready var player_ship := $"../PlayerShip"
var star_scene = load("res://AssetScenes/star.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	# test stuff, loading a scene in to a background
	var star = star_scene.instantiate()
	star.position.x=100.0
	star.position.y=100.0
	$Near.add_child(star)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scroll_offset -= (player_ship.velocity + scroll_speed) * delta 
