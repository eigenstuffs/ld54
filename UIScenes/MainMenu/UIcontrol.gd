extends Control

var isShowing = false

@export var audio : NodePath

func _ready():
	$CenterContainer/PlayButton.grab_focus()

func _on_play_button_pressed():
	LeaderboardBackend.can_move = true
	get_parent().get_node("InGameUI").get_node("Control").init()
	hide()
#	get_tree().change_scene_to_file("res://Levels/lvl1/lvl1.tscn")

func _on_credits_button_pressed():
#	get_tree().change_scene_to_file("res://UIScenes/Credits/credits_scene.tscn")
	$CenterContainer/CreditsButton.release_focus()
	$CenterContainer.hide()
	$CreditsScene.show()
	await $CreditsScene.back
	$CenterContainer.show()
	$CreditsScene.hide()
	$CenterContainer/CreditsButton.grab_focus()

func _on_lvl_select_pressed():
#	get_tree().change_scene_to_file("res://UIScenes/LVLSelect/lvl_select.tscn")
	$CenterContainer/LvlSelect.release_focus()
	$CenterContainer.hide()
	$lvlSelect.show()
	await $lvlSelect.back
	$CenterContainer.show()
	$lvlSelect.hide()
	$CenterContainer/LvlSelect.grab_focus()

func _on_quit_button_pressed():
	get_tree().quit()

func _on_how_2_button_pressed():
	$CenterContainer/How2Button.release_focus()
	$CenterContainer.hide()
	$HowTo.show()
	await $HowTo.back
	$CenterContainer.show()
	$HowTo.hide()
	$CenterContainer/How2Button.grab_focus()

func _on_settings_button_pressed():
	if !$SettingsButton.pressed: get_node(audio).volume_db = 0
	else: get_node(audio).volume_db = -100

	
