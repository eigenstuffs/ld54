extends Node

const level_1 = preload("res://Levels/lvl1/lvl1.tscn")
const level_2 = preload("res://Levels/lvl2/lvl2.tscn")
const level_3 = preload("res://Levels/lvl3/lvl_3.tscn")
const level_4 = preload("res://Levels/lvl4/lvl4.tscn")
const level_5 = preload("res://Levels/lvl5/lvl_5.tscn")

var current_level = 0

@onready var levels = [level_1, level_2, level_3, level_4, level_5]

func change(level : int):
	current_level = level
	$CanvasLayer/AnimationPlayer.play("Fade")
	await $CanvasLayer/AnimationPlayer.animation_finished
	for i in get_children():
		if i is Node3D: 
			remove_child(i)
			i.queue_free()
	var a = levels[level-1].instantiate()
	add_child(a)
	$CanvasLayer/AnimationPlayer.play("Fade_2")
	await $CanvasLayer/AnimationPlayer.animation_finished
	$CanvasLayer/MainMenu.show()
