extends Control

# Exposed variables

@export var game_over : NodePath

@onready var sheepCounterLabel: Label = $Labels/SheepCounter
@onready var levelLabel: Label = $Labels/Level
@onready var timerLabel: Label = $Labels/Timer
@onready var colorRect: ColorRect = $PauseMenu
@onready var centerContainer: CenterContainer = $PauseMenu/CenterContainer
@onready var pauseButton: TextureButton = $Pause
@onready var quitButton: TextureButton = $PauseMenu/CenterContainer/VBoxContainer/Quit
@onready var resumeButton: TextureButton = $PauseMenu/CenterContainer/VBoxContainer/Resume

# Timer variables
var startTime: float
var pausedTime: float
var isPaused: bool = false
var time_passed : float = 0.0

func _ready():
	LeaderboardBackend.connect("stop_timer", stop_timer)

func init():
	$Pause.show()
	$Labels.show()
	time_passed = 0.0
	isPaused = false

func _process(delta):
	# Check for the number of objects with the "Sheep" tag
	var sheepCount = get_tree().get_nodes_in_group("Sheep").size()
	sheepCounterLabel.text = str(sheepCount)

	# Update the timer if not paused
	if !isPaused:
		update_timer_label(delta)

func update_timer_label(delta):
	var currentTime = Time.get_ticks_msec() / 1000.0
	var elapsedTime = currentTime - startTime - pausedTime
	var minutes = int(elapsedTime / 60.0)
	var seconds = int(int(elapsedTime) % 60)
	if !isPaused and LeaderboardBackend.can_move:
		time_passed += delta
		timerLabel.text = "%s.%03d" % [int(time_passed), int((time_passed - int(time_passed)) * 1000)] + "s"

# Custom signals for button presses
signal pause_button_pressed
signal quit_button_pressed
signal resume_button_pressed


func _on_pause_pressed():
	# Pause the game
	LeaderboardBackend.can_move = false
	emit_signal("pause_button_pressed")
	isPaused = true
	pausedTime += Time.get_ticks_msec() / 1000.0 - startTime
	colorRect.visible = true
	centerContainer.show()

func _on_quit_pressed():
	emit_signal("quit_button_pressed")
	get_tree().reload_current_scene()

func _on_resume_pressed():
	# Resume the game
	LeaderboardBackend.can_move = true
	emit_signal("resume_button_pressed")
	isPaused = false
	startTime = Time.get_ticks_msec() / 1000.0 - pausedTime
	pausedTime = 0
	colorRect.visible = false
	centerContainer.hide()
	
func stop_timer():
	LeaderboardBackend.can_move = false
	get_node(game_over).show()
	get_node(game_over).initialize(time_passed)
