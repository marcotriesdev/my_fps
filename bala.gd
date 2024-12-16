extends Node3D

var power = 1
var speed = 500
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(-Vector3.FORWARD * speed * delta)
	pass


func _on_timer_timeout():
	queue_free()
