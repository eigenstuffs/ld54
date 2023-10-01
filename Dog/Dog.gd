extends CharacterBody3D

class_name Dog

const SPEED = 5.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
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
