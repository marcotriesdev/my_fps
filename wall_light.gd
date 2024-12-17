extends Node3D

@export var light_color: Color = Color(1, 1, 1, 1)
@onready var light = $OmniLight3D

# Called when the node enters the scene tree for the first time.
func _ready():
	light.light_color = light_color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _change_color(new_color):
	print("changed color omg")
	light_color = new_color
	light.light_color = light_color
