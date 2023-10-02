extends Control

signal back

func _on_back_pressed():
	emit_signal("back")
#	get_tree().change_scene_to_file("res://UIScenes/MainMenu/UIcontrol.tscn")
