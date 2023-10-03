extends Sprite2D

@export var twinkle_frequency := 2
@export var twinkle_scale := 0.08

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var t = Time.get_ticks_msec()
	# angle in radians that matches desired frequency
	var s = t / 1000.0 * twinkle_frequency * PI
	scale.x = 1 - cos(s) * twinkle_scale
	scale.y = 1 - sin(s) * twinkle_scale
