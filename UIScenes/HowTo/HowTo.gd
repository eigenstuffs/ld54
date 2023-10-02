extends Control

signal back

func _on_button_pressed():
	emit_signal("back")
