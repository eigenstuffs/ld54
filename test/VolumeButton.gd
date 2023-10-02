extends TextureButton

var audio_player: AudioStreamPlayer

# Track whether the sound is muted or not
var sound_muted: bool = false

func _ready():
   
	connect("pressed", _on_button_pressed)

	# Initialize the audio player reference
	audio_player = $AudioStreamPlayer

func _on_button_pressed():
	# Toggle sound state (mute/unmute)
	sound_muted = !sound_muted
	
	if sound_muted:
		audio_player.volume_db = -100
		self.texture_normal = load("res://UI Assets/muted.png")
	else:
		# Unmute the audio by restoring the original volume (0 dB)
		audio_player.volume_db = 0
		self.texture_normal = load("res://UI Assets/unmuted.png")
