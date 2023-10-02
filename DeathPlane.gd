extends Area3D

func _on_body_entered(body):
	if body is Sheep:
		body.queue_free()
	elif body is Dog:
		get_tree().reload_current_scene()
