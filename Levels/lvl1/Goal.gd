extends Area3D

var num_sheep = 0
var sheepCount = 0

func _ready():
	var sheepCount = get_tree().get_nodes_in_group("Sheep").size()
	print(sheepCount)

func _on_body_entered(body):
	if body is Sheep:
		num_sheep += 1
		if num_sheep >= sheepCount:
			print("done")
			LeaderboardBackend.emit_signal("stop_timer")
		

func _on_body_exited(body):
	if body is Sheep:
		num_sheep -= 1
