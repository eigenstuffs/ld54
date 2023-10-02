extends Area3D

func _on_body_entered(body):
	if body is Sheep:
		body.queue_free()
		get_parent().get_node("WorldEnvironment").red_flare()
	elif body is Dog:
		get_tree().reload_current_scene()
	$AudioStreamPlayer.play()
