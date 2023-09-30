extends CharacterBody3D


const SPEED = 5.0

var vel: Vector3 = Vector3()
enum states {
	ALERTED,
	UNALERTED,
	STOMPED,
	DEAD
}
var state := states.UNALERTED
@export var player : NodePath
@export var run_speed : float = 2.0
@export var walk_speed : float = 1.0
var unalerted_walk : bool = true
var walk_angle : float = 0.0

# when barked at, switch_state(states.ALERTED)
func _ready():
	switch_state(states.UNALERTED)
	
func _physics_process(delta):
	# Add the gravity.
#	if not is_on_floor():
#		velocity.y -= gravity * delta
	if vel:
		velocity.x = vel.x
		velocity.z = vel.y
	else:
		velocity.x = move_toward(velocity.x, 0, 0.1)
		velocity.z = move_toward(velocity.z, 0, 0.1)
	move_and_slide()

func switch_state(new_state : int):
	$Timer.stop()
	match new_state:
		states.ALERTED:
			pass
		states.UNALERTED:
			unalerted_walk = true
			walk_angle = randf_range(-PI, PI)
			$Timer.start(randf_range(0.5, 5.0))
		states.STOMPED:
			$Timer.start(5.0)
		states.DEAD:
			queue_free()
		_:
			pass
	state = new_state
	
func _process(delta):
	match state:
		states.ALERTED:
			vel = (get_node(player).global_position - global_position).normalized() * Vector3(1, 0, 1) * run_speed
			if ((get_node(player).global_position - global_position) * Vector3(1, 0, 1)).length() > 10:
				switch_state(states.UNALERTED)
		states.UNALERTED:
			if unalerted_walk:
				vel = Vector3(1, 0, 1).rotated(Vector3(0, 1, 0), walk_angle)
			else:
				vel = Vector3()
		states.STOMPED:
			queue_free()
#			vel = Vector3()
		states.DEAD:
			pass
		_:
			pass

func _on_timer_timeout():
	match state:
		states.UNALERTED:
			unalerted_walk = !unalerted_walk
			$Timer.start(randf_range(0.5, 5.0))
		states.STOMPED:
			switch_state(states.DEAD)
		_:
			pass

func _on_hurtbox_area_entered(area):
	if area is Bark:
		print("barked")
		switch_state(states.ALERTED)
	elif area is Hitbox:
		print("stomped")
		switch_state(states.STOMPED)
