extends ProgressBar

var color_map = {
	100: Color.WHITE,
	75: Color.YELLOW,
	50: Color.ORANGE,
	25: Color.RED
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_value_changed(new_value):
	for v in color_map:
		if new_value <= v:
			self_modulate = color_map[v]
