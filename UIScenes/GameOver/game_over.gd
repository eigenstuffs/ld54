extends Control

signal retried
signal nextlvl

@onready var time : = $CenterContainer/VBoxContainer/Time

func initialize(total_play_time : float) -> void:
	var minutes : String = str(int(total_play_time / 60.0))
	var seconds : String = str(int(fmod(total_play_time, 60.0)))
	var time_text = "Total Time : %s m %s s" %[minutes,seconds]
	time.text = time_text
	
func _on_exit_pressed():
	get_tree().change_scene_to_file("res://UIScenes/MainMenu/UIcontrol.tscn")
 
func _on_nextlvl_pressed():
	emit_signal("nextlvl ")

func _on_retry_pressed():
	emit_signal("retried")
