extends Control

# Exposed variables
var sheepCounterLabel: Label
var levelLabel: Label
var timerLabel: Label
var pauseButton: Button
var colorRect: ColorRect
var centerContainer: CenterContainer
var retryButton: Button
var quitButton: Button
var resumeButton: Button

# Timer variables
var startTime: float
var pausedTime: float
var isPaused: bool = false

func _ready():
	# Connect button signals
	pauseButton.connect_signal("pressed", self, "_on_pause_pressed")
	retryButton.connect_signal("pressed", self, "_on_retry_pressed")
	quitButton.connect_signal("pressed", self, "_on_quit_pressed")
	resumeButton.connect_signal("pressed", self, "_on_resume_pressed")

	# Start the timer
	startTime = Time.get_ticks_msec() / 1000.0
	update_timer_label()

func _process(delta):
	# Check for the number of objects with the "Sheep" tag
	var sheepCount = get_tree().get_nodes_in_group("Sheep").size()
	sheepCounterLabel.text = str(sheepCount)

	# Update the timer if not paused
	if !isPaused:
		update_timer_label()

func update_timer_label():
	var currentTime = Time.get_ticks_msec() / 1000.0
	var elapsedTime = currentTime - startTime - pausedTime
	var minutes = int(elapsedTime / 60)
	var seconds = int(elapsedTime % 60)
	timerLabel.text = String().format("%02d:%02d") %[minutes, seconds]

# Custom signals for button presses
signal pause_button_pressed
signal retry_button_pressed
signal quit_button_pressed
signal resume_button_pressed


func _on_pause_pressed():
	# Pause the game
	emit_signal("pause_button_pressed")
	isPaused = true
	pausedTime += Time.get_ticks_msec() / 1000.0 - startTime
	colorRect.visible = true
	centerContainer.show()

func _on_retry_pressed():
	# Reload the current scene
	emit_signal("retry_button_pressed")
	get_tree().reload_current_scene()

func _on_quit_pressed():
	emit_signal("quit_button_pressed")
	get_tree().change_scene_to_file("res://UIScenes/MainMenu/UIcontrol.tscn")

func _on_resume_pressed():
	# Resume the game
	emit_signal("resume_button_pressed")
	isPaused = false
	startTime = Time.get_ticks_msec() / 1000.0 - pausedTime
	pausedTime = 0
	colorRect.visible = false
	centerContainer.hide()
	
