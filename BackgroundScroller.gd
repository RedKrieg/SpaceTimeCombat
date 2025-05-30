extends ParallaxBackground

@export var scroll_speed := Vector2(1550.0, 0.0)
@export var stars_per_layer_base:int = 150
@export var max_star_scrambles:int = 16
@onready var player_ship := $"../PlayerShip"
var star_scene = preload("res://AssetScenes/star.tscn")
var rng = RandomNumberGenerator.new()
var star_color_palette = PackedColorArray([
	Color.from_string("#afc9ff", Color.WHITE),
	Color.from_string("#c7d8ff", Color.WHITE),
	Color.from_string("#fff4f3", Color.WHITE),
	Color.from_string("#ffe5cf", Color.WHITE),
	Color.from_string("#ffd9b2", Color.WHITE),
	Color.from_string("#ffc78e", Color.WHITE),
	Color.from_string("#ffa651", Color.WHITE)
])

# Called when the node enters the scene tree for the first time.
func _ready():
	var layers = get_children()
	var layer_count = layers.size()
	for i in layer_count:
		if i == 0:
			continue # no fixed stars
		var layer_size = layers[i].motion_mirroring
		for s in 2**(layer_count-i-1)*stars_per_layer_base:
			var star = star_scene.instantiate()
			var new_scale = rng.randf_range(0.8, 1.2) * layers[i].motion_scale
			star.scale = new_scale
			star.position = get_random_position(star, layer_size, new_scale)
			var scrambles = max_star_scrambles
			while overlaps(star, layers[i].get_children()) and scrambles > 0:
				star.position = get_random_position(star, layer_size, new_scale)
				scrambles -= 1
			star.position.x = rng.randf_range(
				star.texture.get_width()/2/new_scale.x,
				layer_size.x-star.texture.get_width()/2/new_scale.x
				)
			star.position.y = rng.randf_range(
				star.texture.get_height()/2/new_scale.y,
				layer_size.y-star.texture.get_height()/2/new_scale.y
				)
			var new_color = star_color_palette[rng.randi() % star_color_palette.size()]
			star.self_modulate = new_color
			layers[i].add_child(star)

func get_random_position(star, layer_size, new_scale):
	return Vector2(
		rng.randf_range(
			star.texture.get_width()/2/new_scale.x,
			layer_size.x-star.texture.get_width()/2/new_scale.x
		),
		rng.randf_range(
			star.texture.get_height()/2/new_scale.y,
			layer_size.y-star.texture.get_height()/2/new_scale.y
		)
	)

func overlaps(star, starfield):
	var dist = Vector2(
		star.texture.get_width()*star.scale.x,
		star.texture.get_height()*star.scale.y
		).length()*2
	for s in starfield:
		if (s.position - star.position).length() < dist:
			return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var current_speed = scroll_speed
	if player_ship.boosting:
		current_speed *= 1.5
	scroll_offset -= (player_ship.velocity + current_speed) * delta
