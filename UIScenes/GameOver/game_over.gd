extends Control

signal retried
signal nextlvl

@onready var time : = $CenterContainer/VBoxContainer/Timer
@onready var title : = $CenterContainer/VBoxContainer/Title

func initialize(total_play_time : float = 0.0, won : bool = true) -> void:
#	var minutes : String = str(int(total_play_time / 60.0))
#	var seconds : String = str(int(fmod(total_play_time, 60.0)))
#	var time_text = "Total Time : %s m %s s" %[minutes,seconds]
	show()
	if won:
		title.text = "Success!"
		time.text = "Your time: " + str(snapped(total_play_time, 0.01))
	else:
		time.text = "Try again!"
		title.text = "All your sheep fell off :("
#	time.text = time_text
	
func _on_exit_pressed():
	get_tree().change_scene_to_file("res://test/game.tscn")
	hide()
 
func _on_nextlvl_pressed():
	get_tree().current_scene.get_node("Level").change(min(6, get_tree().current_scene.get_node("Level").current_level+1))
	hide()

func _on_retry_pressed():
	get_tree().current_scene.get_node("Level").change(get_tree().current_scene.get_node("Level").current_level)
	hide()
