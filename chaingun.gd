extends Node3D

var rotation_speed = 0
var rotar = false
var bullet = preload("res://bala.tscn")
var casing = preload("res://casing.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var bullet = preload("res://bala.tscn")
	var raiz = get_tree().current_scene
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var gunpoint = get_parent().get_node("Camera3D2/gunpoint")
	global_transform.origin.x = lerp(global_transform.origin.x,gunpoint.global_transform.origin.x,0.9)
	global_transform.origin.y = lerp(global_transform.origin.y,gunpoint.global_transform.origin.y,0.9)
	global_transform.origin.z = lerp(global_transform.origin.z,gunpoint.global_transform.origin.z,0.9)
	
	global_rotation.y = get_parent().get_node("Camera3D2/gunpoint").global_rotation.y
	global_rotation.x = lerp_angle(global_rotation.x,get_parent().get_node("Camera3D2/gunpoint").global_rotation.x,0.81)

	if $AnimationPlayer.current_animation == "light" and Global.player_ammo["bullets"]<=0:
		$AnimationPlayer.play("RESET")
		
	if rotar:
		rotar_tubo()
	else:
		$Timer.stop()
		if rotation_speed > 0:
			rotation_speed -= 0.02
		if rotation_speed <= 0:
			rotation_speed = 0
		$tubo_giratorio.rotation.z += rotation_speed
		$AnimationPlayer.play("RESET")
	
	
func rotar_tubo():
	if $Timer.is_stopped() and Global.player_ammo["bullets"] > 0:
		$Timer.start()
	if rotation_speed < 1:
		rotation_speed += 0.01
	elif rotation_speed >= 1:
		rotation_speed = 1
	$tubo_giratorio.rotation.z += rotation_speed


func _on_timer_timeout():

		%AnimationPlayer.play("light")

func shoot_bullet():
	Global.player_ammo["bullets"] -= 1
	var new_bullet = bullet.instantiate()
	new_bullet.global_transform = %shooter.global_transform
	get_parent().get_parent().add_child(new_bullet)
	shoot_casing()
	

func shoot_casing():
	
	var new_casing = casing.instantiate()
	new_casing.global_transform = $casing_shooter.global_transform
	
	var impulse = Vector3(0, 0, -20) # El impulso se da en la dirección Z negativa (hacia adelante)
	# Si el objeto es un RigidBody3D, aplicamos el impulso
	if new_casing is RigidBody3D:
		new_casing.apply_impulse(Vector3.ZERO, impulse) # Aplica el impulso desde el centro de la bala
	get_parent().get_parent().add_child(new_casing)	
