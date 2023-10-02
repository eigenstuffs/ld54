extends Control

signal retried
signal nextlvl

@onready var time : = $CenterContainer/VBoxContainer/TextureRect/Timer

func initialize(total_play_time : float = 0.0, won : bool = true) -> void:
#	var minutes : String = str(int(total_play_time / 60.0))
#	var seconds : String = str(int(fmod(total_play_time, 60.0)))
#	var time_text = "Total Time : %s m %s s" %[minutes,seconds]
	print("showing game over")
	show()
	if won:
		time.text = "Your time: " + str(snapped(total_play_time, 0.01))
	else:
		time.text = "Try again!"
#	time.text = time_text
	
func _on_quit_pressed():
	get_tree().change_scene_to_file("res://test/game.tscn")
 
<<<<<<< HEAD
func _on_nextlvl_pressed():
	get_tree().current_scene.get_node("Level").change(min(6, get_tree().current_scene.get_node("Level").current_level+2))
=======
func _on_next_pressed():
	get_tree().current_scene.get_node("Level").change(min(6, get_tree().current_scene.get_node("Level").current_level+1))
>>>>>>> 000dd4ae2549d081dbc30ab903538f94bbbd35d6
	hide()

func _on_replay_pressed():
	get_tree().current_scene.get_node("Level").change(get_tree().current_scene.get_node("Level").current_level)
	hide()

