extends Sprite2D

@export var twinkle_frequency := 2
@export var twinkle_scale := 0.08
var original_scale
# Called when the node enters the scene tree for the first time.
func _ready():
	original_scale = scale


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var t = Time.get_ticks_msec()
	# angle in radians that matches desired frequency
	var s = t / 1000.0 * twinkle_frequency * PI
	scale.x = original_scale.x * (1 - cos(s) * twinkle_scale)
	scale.y = original_scale.y * (1 - sin(s) * twinkle_scale)
