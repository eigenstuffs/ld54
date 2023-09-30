extends Control



func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://Dog/test.tscn")


func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://UIControl/SettingsMenu/settings_menu.tscn")


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://UIControl/Credits/credits_scene.tscn")



func _on_lvl_select_pressed():
	get_tree().change_scene_to_file("res://UIControl/LVLSelect/lvl_select.tscn")



func _on_quit_button_pressed():
	get_tree().quit()
