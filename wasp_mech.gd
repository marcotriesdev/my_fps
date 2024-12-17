extends Node3D

var random_start = randf_range(0,1.5)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.seek(random_start)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
