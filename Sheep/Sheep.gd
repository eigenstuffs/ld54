extends CharacterBody3D

class_name Sheep

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
@export var run_speed : float = 4.0
@export var walk_speed : float = 1.0
@export var sheepmodel : NodePath
var animator : AnimationPlayer
var unalerted_walk : bool = true
var walk_angle : float = 0.0
var just_switched_walk_angle : bool = false
var player_node : Node 

# when barked at, switch_state(states.ALERTED)
func _ready():
	player_node = get_node(player)
	animator = get_node("sheep/AnimationPlayer")
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
			animator.play("push up")
			animator.queue("run")
			pass
		states.UNALERTED:
			animator.play("pull down")
			animator.queue("idle")
			unalerted_walk = true
			walk_angle = randf_range(-PI, PI)
			$Timer.start(randf_range(3.0, 5.0))
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
	if not is_on_floor():
		velocity.y -= gravity * delta
	if vel:
		velocity.x = vel.x
		velocity.z = vel.z
	else:
		velocity.x = lerpf(velocity.x, 0.0, delta * 0.2)
		velocity.z = lerpf(velocity.z, 0.0, delta * 0.2)
	if velocity.length() > 0:
		var target_position = global_position + velocity
		$sheep.rotation.y = lerp_angle($sheep.rotation.y, atan2(velocity.x, velocity.z), delta * 10.0)
		#$FrontDetection.look_at(target_position, Vector3(0, 1, 0))
	match state:
		states.ALERTED:
			vel = (player_node.global_position - global_position).normalized() * Vector3(1, 0, 1) * (run_speed) * -1
#			print(vel)
			if ((player_node.global_position - global_position) * Vector3(1, 0, 1)).length() > 5:
				switch_state(states.UNALERTED)
		states.UNALERTED:
			if unalerted_walk:
				#if ((player_node.global_position - global_position) * Vector3(1, 0, 1)).length() > 2:
				vel = Vector3(1, 0, 1).rotated(Vector3(0, 1, 0), walk_angle) * walk_speed
			else:
				vel = Vector3()
		states.STOMPED:
			pass
#			vel = Vector3()
		states.DEAD:
			pass
		_:
			pass
	if LeaderboardBackend.can_move: move_and_slide()

func _on_timer_timeout():
	match state:
		states.UNALERTED:
			if unalerted_walk:
				$Timer.stop()
				$Timer.start(randf_range(3.0, 5.0))
			else:
				walk_angle = randf_range(-PI, PI)
				$Timer.stop()
				$Timer.start(randf_range(3.0, 5.0))
			unalerted_walk = !unalerted_walk
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

func is_safe() -> bool:
	for i in $Rays.get_children():
		if !i.is_colliding():
			return false
	return true


func _on_front_detection_body_entered(body):
	match state:
		states.UNALERTED:
			# fix this being able to happen multiple times with one body maybe
			if unalerted_walk:
				$Timer.stop()
				$Timer.start(randf_range(3.0, 5.0))
				unalerted_walk = true
				walk_angle = walk_angle + PI + randf_range(-PI/6, PI/6)
