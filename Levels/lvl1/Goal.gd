extends Area3D

var num_sheep = 0
var sheep_count = 0

func _process(delta):
	sheep_count = get_tree().get_nodes_in_group("Sheep").size()
	for i in get_overlapping_bodies():
		if i is Sheep:
			num_sheep += 1
	if num_sheep >= sheep_count:
		print("done")
		LeaderboardBackend.emit_signal("stop_timer")
	num_sheep = 0
#
#func _on_body_entered(body):
#	if body is Sheep:
#		num_sheep += 1
#		if num_sheep >= sheepCount:
#			print("done")
#			LeaderboardBackend.emit_signal("stop_timer")
#
#func _on_body_exited(body):
#	if body is Sheep:
#		num_sheep -= 1
