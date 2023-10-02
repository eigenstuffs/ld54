extends Area3D

func _on_body_entered(body):
	if body is Sheep:
		body.remove_from_group("Sheep")
		body.queue_free()
		get_parent().get_node("WorldEnvironment").red_flare()
		var sheepCount = get_tree().get_nodes_in_group("Sheep").size()
		if sheepCount <= 0:
			get_tree().current_scene.get_node("Level").get_node("CanvasLayer").get_node("GameOver").initialize(0.0, false)
	elif body is Dog:
		get_tree().reload_current_scene()
	$AudioStreamPlayer.play()
