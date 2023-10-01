extends Control

func _on_back_pressed():
	get_tree().change_scene_to_file("res://UIScenes/MainMenu/UIcontrol.tscn")

func _on_lvl_1_pressed():
	get_tree().change_scene_to_file("res://Levels/lvl1/lvl1.tscn")
	
func _on_lvl_2_pressed():
	get_tree().change_scene_to_file("res://Levels/lvl2/lvl2.tscn")

func _on_lvl_3_pressed():
	get_tree().change_scene_to_file("res://Levels/lvl3/lvl_3.tscn")

func _on_lvl_4_pressed():
	get_tree().change_scene_to_file("res://Levels/lvl4/lvl4.tscn")

func _on_lvl_5_pressed():
	get_tree().change_scene_to_file("res://Levels/lvl5/lvl_5.tscn")
