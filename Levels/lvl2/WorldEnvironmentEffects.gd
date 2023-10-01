extends WorldEnvironment

var counter = 0
var flaring = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Setup
	environment.fog_enabled = true
	environment.fog_density = 0
	environment.fog_sky_affect = 0
	environment.fog_light_color = Color.RED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		red_flare()
	pass


func red_flare():
	if flaring:
		counter = 0
		return
	flaring = true
	counter = 0
	while counter < 50:
		await get_tree().create_timer(0.02).timeout
		var amt = 1 - counter * 0.02
		environment.fog_sky_affect = amt
		environment.fog_density = amt * 0.01
		counter += 1
	flaring = false
	pass
