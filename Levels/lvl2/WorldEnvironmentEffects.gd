extends WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready():
	red_flare()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func red_flare():
	environment.background_mode = Environment.BG_COLOR
	environment.background_color = Color.RED
	pass
