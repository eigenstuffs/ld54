extends Node3D

@export var target : NodePath

var dog : CharacterBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	dog = get_node(target)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var pos : Vector3 = dog.global_position
	self.global_position.lerp(pos, 0.2 * delta)
