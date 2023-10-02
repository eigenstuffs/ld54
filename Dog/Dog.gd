extends CharacterBody3D

class_name Dog

const SPEED = 5.0
const ACCEL = 5.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var animator : AnimationPlayer

enum DogAnimationState { idle, walk } 
var state := DogAnimationState.idle

func _ready():
	RenderingServer.set_default_clear_color(Color.BEIGE)
	animator = get_node("dog/AnimationPlayer")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (Vector3(input_dir.x, 0, input_dir.y)).normalized().rotated(Vector3(0, 1, 0), PI/4)
	if direction:
		velocity.x = lerpf(velocity.x, direction.x * SPEED, delta * ACCEL)
		velocity.z = lerpf(velocity.z, direction.z * SPEED, delta * ACCEL)
	else:
		velocity.x = lerpf(velocity.x, 0.0, delta * ACCEL * 3.0)
		velocity.z = lerpf(velocity.z, 0.0, delta * ACCEL * 3.0)
	changeAnimationState(direction)
	$dog.rotation.y = lerp_angle($dog.rotation.y, atan2(velocity.x, velocity.z), delta * 10.0)
	if Input.is_action_just_pressed("ui_accept") and LeaderboardBackend.can_move:
		bark()
		$AudioStreamPlayer.play()
		
func _process(delta):
	if LeaderboardBackend.can_move: 
		move_and_slide()
	# move_and_slide()
	
func bark():
	var tween : Tween = create_tween()
	tween.tween_property($Bark/CollisionShape3D, "scale", Vector3(3,3,3), 0.15)
	await tween.finished
	tween = create_tween()
	tween.tween_property($Bark/CollisionShape3D, "scale", Vector3(.1,.1,.1), 0.5)
	await tween.finished

func changeAnimationState(direction):
	if direction:
		if state != DogAnimationState.walk:
			state = DogAnimationState.walk
			animator.play("idle to walk")
			animator.queue("dog run")
	else:
		if state != DogAnimationState.idle:
			state = DogAnimationState.idle
			animator.play("walk to idle")
			animator.queue("dog idle")
