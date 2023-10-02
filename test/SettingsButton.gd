extends TextureButton

var normalTextures : Array = []
var pressedTextures : Array = []

var currentTextureIndex : int = 0

func _ready():
	connect("pressed", _on_button_pressed)
	
	for i in range(6):
		var normalTexturePath = "res://UIAssests/volume_idle" + str(i) + ".png"
		var pressedTexturePath = "res://UIAssests/volume_hover" + str(i) + ".png"
		
		var normalTexture = load(normalTexturePath)
		var pressedTexture = load(pressedTexturePath)

		normalTextures.append(normalTexture)
		pressedTextures.append(pressedTexture)

func _on_button_pressed():
	currentTextureIndex = (currentTextureIndex + 1) % 6
	self.texture_normal = normalTextures[currentTextureIndex]
	self.texture_pressed = pressedTextures[currentTextureIndex]
