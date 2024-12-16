extends CharacterBody3D

# Sensibilidad del mouse
@export var mouse_sensitivity: Vector2 = Vector2(0.01, 0.01)

# Velocidad de movimiento
@export var original_move_speed: float = 1200
var run_speed = original_move_speed * 1.7
@export var move_speed: float = original_move_speed

@export var jumpForce = 40
var gravity = 95

@export var friction: float = 150
var air_friction = 20
var direction: Vector3 = Vector3.ZERO	
# Límites de rotación vertical (evita que la cámara gire completamente)
@export var vertical_rotation_limit: float = 85.0

# Variables para manejar la rotación acumulada
var rotation_horizontal: float = 0.0
var rotation_vertical: float = 0.0

# Referencia a la cámara
var camera: Camera3D

var activate: bool = false

func _ready():
	# Captura el mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$SpotLight3D.visible = false
	
	# Obtén la referencia al nodo Camera3D
	camera = get_parent().get_node("Camera3D2")
	
	# Verifica que el nodo existe para evitar errores
	if not camera:
		print("No se encontró un nodo Camera3D como hijo del CharacterBody3D.")

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		handle_mouse_motion(event)

func _process(delta):
	
	handle_movement(delta)
	_shoot(delta)

func _shoot(delta):
	if Input.is_action_pressed("clic"):
		%chaingun.rotar = true
	else:
		%chaingun.rotar = false
	

func handle_mouse_motion(event: InputEventMouseMotion):
	if not camera:
		return # Salir si no se encuentra la cámara

	# Ajusta la rotación horizontal y vertical basándote en el movimiento del mouse
	rotation_horizontal -= event.relative.x * mouse_sensitivity.x
	rotation_vertical = clamp(
		rotation_vertical - event.relative.y * mouse_sensitivity.y,
		-deg_to_rad(vertical_rotation_limit),
		deg_to_rad(vertical_rotation_limit)
	)
	
	# Aplica la rotación horizontal al CharacterBody3D (gira el personaje)
	rotation = Vector3(0, rotation_horizontal, 0)
	
	# Aplica la rotación vertical al Camera3D (gira la cámara hacia arriba/abajo)
	camera.rotation.x = rotation_vertical
	camera.rotation.y = rotation_horizontal


func handle_movement(delta):
	# Calcula la dirección del movimiento
	
	if move_speed > 0:
		move_speed -= friction 
	elif move_speed < 0:
		move_speed = 0
	
	if Input.is_action_pressed("run"):
		original_move_speed = run_speed
	else:
		original_move_speed = 1200
	
	# Inputs predeterminados (ui_left, ui_right, ui_up, ui_down)
	if Input.is_action_pressed("ui_up"):
		direction -= transform.basis.z
		move_speed = original_move_speed
	if Input.is_action_pressed("ui_down"):
		direction += transform.basis.z
		move_speed = original_move_speed
	if Input.is_action_pressed("ui_left"):
		direction -= transform.basis.x
		move_speed = original_move_speed
	if Input.is_action_pressed("ui_right"):
		direction += transform.basis.x
		move_speed = original_move_speed
	if Input.is_action_pressed("activate"):
		activate = true
		$Area3D.monitorable = true
	else:
		activate = false
		$Area3D.monitorable = false

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jumpForce
	
	if Input.is_action_just_pressed("flashlight"):
		$SpotLight3D.visible = not $SpotLight3D.visible

	
	if not is_on_floor():	
		friction = air_friction
		velocity.y -= gravity * delta # Aplicamos gravedad
	if is_on_floor():
		friction = 150
		
	#print("is on floor: "+ str(is_on_floor()))
	#print(velocity.y)
	
	# Normaliza la dirección para evitar velocidades mayores en movimientos diagonales
	direction = direction.normalized()
	

	# Mueve el personaje
	velocity.x = direction.x * move_speed * delta
	velocity.z = direction.z * move_speed * delta
	
	move_and_slide()



