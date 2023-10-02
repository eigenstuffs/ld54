extends Control
func _ready():
	await get_tree().create_timer(1).timeout
	$AnimationPlayer.play("Fade")
	await get_tree().create_timer(5).timeout
	$AnimationPlayer.play_backwards("Fade")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://test/game.tscn")
	pass
