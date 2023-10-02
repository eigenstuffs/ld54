extends Control

var isShowing = false

func _ready():
	$CenterContainer/PlayButton.grab_focus()

func _on_play_button_pressed():
	LeaderboardBackend.can_move = true
	queue_free()
#	get_tree().change_scene_to_file("res://Levels/lvl1/lvl1.tscn")

func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://UIScenes/SettingsMenu/settings_menu.tscn")

func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://UIScenes/Credits/credits_scene.tscn")

func _on_lvl_select_pressed():
	get_tree().change_scene_to_file("res://UIScenes/LVLSelect/lvl_select.tscn")

func _on_quit_button_pressed():
	get_tree().quit()

func _on_how_2_button_pressed():
	pass
