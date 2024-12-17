extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = get_parent().get_node("CharacterBody3D").global_position + Vector3(0,5.5,0)
	$dynamic_hud/Node2D/Label.text = "-Press [color=green]SHIFT[/color] to run \n
-Press [color=green]SPACE[/color] to jump \n
-Press [color=green]F[/color] for flashlight \n
-Press [color=green]E[/color] to activate switches \n
FLASHLIGHT:  %s" %[str(int(Global.flashlight_battery))]
	
