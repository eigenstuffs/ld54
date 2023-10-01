extends WorldEnvironment


# Called when the node enters the scene tree for the first time.
func _ready():
	red_flare()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func red_flare():
	var amt = 1
	for i in range(50):
		await get_tree().create_timer(0.02).timeout
		amt -= 0.02
		environment.fog_sky_affect = amt
		environment.fog_density = amt * 0.01
	pass
