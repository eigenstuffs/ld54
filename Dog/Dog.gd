extends CharacterBody3D

class_name Dog

const SPEED = 5.0
const ACCEL = 5.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	RenderingServer.set_default_clear_color(Color.BEIGE)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized().rotated(Vector3(0, 1, 0), PI/4)
	if direction:
		velocity.x = lerpf(velocity.x, direction.x * SPEED, delta * ACCEL)
		velocity.z = lerpf(velocity.z, direction.z * SPEED, delta * ACCEL)
	else:
		velocity.x = lerpf(velocity.x, 0.0, delta * ACCEL * 3.0)
		velocity.z = lerpf(velocity.z, 0.0, delta * ACCEL * 3.0)
	
	if Input.is_action_just_pressed("ui_accept"):
		bark()
		
func _process(delta):
	move_and_slide()

func bark():
	var tween : Tween = create_tween()
	tween.tween_property($Bark/CollisionShape3D, "scale", Vector3(3,3,3), 0.15)
	await tween.finished
	tween = create_tween()
	tween.tween_property($Bark/CollisionShape3D, "scale", Vector3(.1,.1,.1), 0.5)
	await tween.finished
