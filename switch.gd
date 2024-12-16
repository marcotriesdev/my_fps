extends Node3D

@export var path_array: Array
var door_array: Array

var on = false
var used = false

signal open_door
# Called when the node enters the scene tree for the first time.

func _load_doors():
	for path in path_array:
		door_array.append(get_node(path))
		print("added path: "+ str(path))
	
	for node in door_array:
		connect("open_door",Callable(node,"_open"))
		print("added node: "+ str(node))

func _ready():
	#var door = get_node(door_path)
	#connect("open_door",Callable(door,"_open"))
	_load_doors()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("switch on?: " + str(on) + "used: " + str(used))
	if on and Input.is_action_just_pressed("activate") and not used:
		_open_door()


func _open_door():
	$AnimationPlayer.play("on")
	emit_signal("open_door")
	used = true

func _reset_switch():
	print("switch reseted")
	$AnimationPlayer.play("reset")
	used = false

func _on_switch_area_body_entered(body):
	if body.is_in_group("player"):
		on = true


func _on_switch_area_body_exited(body):
	if body.is_in_group("player"):
		on = false
