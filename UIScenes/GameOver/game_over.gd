extends Control

signal retried
signal nextlvl

@onready var time : = $CenterContainer/VBoxContainer/Timer

func initialize(total_play_time : float) -> void:
#	var minutes : String = str(int(total_play_time / 60.0))
#	var seconds : String = str(int(fmod(total_play_time, 60.0)))
#	var time_text = "Total Time : %s m %s s" %[minutes,seconds]
	time.text = "Your time: " + str(snapped(total_play_time, 0.01))
#	time.text = time_text
	
func _on_exit_pressed():
	get_tree().change_scene_to_file("res://test/game.tscn")
 
func _on_nextlvl_pressed():
	get_tree().current_scene.get_node("Level").change(get_tree().current_scene.get_node("Level").current_level+2)
	hide()

func _on_retry_pressed():
	get_tree().current_scene.get_node("Level").change(get_tree().current_scene.get_node("Level").current_level+1)
	hide()
