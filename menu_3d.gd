extends Node3D

var start : bool = false
var exit : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and exit:
		get_tree().quit()
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and start:
		get_tree().change_scene_to_file("res://map_1.tscn")
		
	
	if start:
		%start_label2.visible = true
	else:
		%start_label2.visible = false
		
	if exit:
		%exit_label2.visible = true
	else:
		%exit_label2.visible = false

func _on_start_label_mouse_entered():
	start = true
	print("start activo")


func _on_start_label_mouse_exited():
	start = false
	print("start inactivo")

func _on_exit_label_mouse_entered():
	exit = true


func _on_exit_label_mouse_exited():
	exit = false
