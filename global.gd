extends Node

var player_ammo = {"bullets": 1000}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if player_ammo["bullets"] < 0:
		player_ammo["bullets"] = 0
	pass
