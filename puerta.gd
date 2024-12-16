extends Node3D

var open = false
@export var self_close: bool = false

@export var switch_path: NodePath

signal reset_switch
# Called when the node enters the scene tree for the first time.
func _ready():
	var switch = get_node(switch_path)
	connect("reset_switch",Callable(switch,"_reset_switch"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func _open():
	print("abriendo puerta")
	$AnimationPlayer.play("open")
	if self_close:
		$Timer.start()
	
func _close():
	print("cerrando puelta")
	$AnimationPlayer.play("closer")


func _on_timer_timeout():
	emit_signal("reset_switch")
	_close()
	
