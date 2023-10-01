extends CharacterBody3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
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
@export var walk_speed : float = 0.5
var unalerted_walk : bool = true
var walk_angle : float = 0.0

var player_node : Node 

# when barked at, switch_state(states.ALERTED)
func _ready():
	player_node = get_node(player)
	switch_state(states.UNALERTED)
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	if vel:
		velocity.x = vel.x
		velocity.z = vel.z
	else:
		velocity.x = move_toward(velocity.x, 0, 0.1)
		velocity.z = move_toward(velocity.z, 0, 0.1)
	

func switch_state(new_state : int):
	$Timer.stop()
	match new_state:
		states.ALERTED:
			pass
		states.UNALERTED:
			unalerted_walk = false
			walk_angle = randf_range(-PI, PI)
			$Timer.start(randf_range(4.0, 8.0))
		states.STOMPED:
			$Timer.start(0.5)
			var a = create_tween()
			a.tween_property($MeshInstance3D, "scale", Vector3(1,0,1), 0.5)
		states.DEAD:
			queue_free()
		_:
			pass
	state = new_state
	
func _process(delta):
	move_and_slide()
	match state:
		states.ALERTED:
			vel = (player_node.global_position - global_position).normalized() * Vector3(1, 0, 1) * (run_speed) * -1
#			print(vel)
			if ((player_node.global_position - global_position) * Vector3(1, 0, 1)).length() > 5:
				switch_state(states.UNALERTED)
				print("unaltered")
		states.UNALERTED:
			if unalerted_walk:
				if ((player_node.global_position - global_position) * Vector3(1, 0, 1)).length() > 2:
					vel = Vector3(1, 0, 1).rotated(Vector3(0, 1, 0), walk_angle) * walk_speed
				else:
					unalerted_walk = false
					$Timer.stop()  # Don't actually know if this is necessary
					$Timer.start(randf_range(5.0, 8.0))
			else:
				vel = Vector3()
		states.STOMPED:
			pass
#			vel = Vector3()
		states.DEAD:
			pass
		_:
			pass

func _on_timer_timeout():
	match state:
		states.UNALERTED:
			unalerted_walk = !unalerted_walk
			if unalerted_walk:
				$Timer.start(randf_range(0.5, 2.0))
			else:
				$Timer.start(randf_range(5.0, 10.0))
		states.STOMPED:
			switch_state(states.DEAD)
		_:
			pass

func _on_hurtbox_area_entered(area):
	if area is Bark:
		print("barked")
		switch_state(states.ALERTED)
	elif area is Hitbox:
		pass
#		print("stomped")
#		switch_state(states.STOMPED)
