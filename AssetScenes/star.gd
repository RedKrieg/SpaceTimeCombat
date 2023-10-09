extends Sprite2D

@export var twinkle_frequency := 2.0
@export var twinkle_scale := 0.08
var original_scale
var twinkle_offset
# Called when the node enters the scene tree for the first time.
func _ready():
	original_scale = scale
	# don't all have the same twinkle pattern
	twinkle_offset = randf_range(0.0, 1000.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var t = Time.get_ticks_msec() + twinkle_offset
	# angle in radians that matches desired frequency
	var s = t / 1000.0 * twinkle_frequency * 2 * PI
	scale.x = original_scale.x * (1 - cos(s) * twinkle_scale)
	scale.y = original_scale.y * (1 - sin(s) * twinkle_scale)
