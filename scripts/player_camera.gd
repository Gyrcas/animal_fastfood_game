extends Node3D
class_name PlayerCamera

const max_angle_y : float = 90

@export var speed : float = 5

@export var force_mult : float = 1

@export var min_force : float = 0.5

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta : float) -> void:
	var dir_z : float = Input.get_axis("forward","backward")
	var dir_x : float = Input.get_axis("left","right")
	
	var move_z : Vector3 = global_transform.basis.z * dir_z
	var move_x : Vector3 = global_transform.basis.x * dir_x
	
	global_position += (move_z + move_x) * speed * delta

func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_camera(event)

func rotate_camera(event : InputEventMouseMotion) -> void:	
	var force_x : float = -event.relative.x * force_mult
	var force_y : float = -event.relative.y * force_mult
	
	if abs(force_x) < min_force:
		force_x = 0
	if abs(force_y) < min_force:
		force_y = 0
	
	rotation_degrees.y += force_x
	
	rotation_degrees.x += force_y
	
	if rotation_degrees.x < -max_angle_y:
		rotation_degrees.x = -max_angle_y
	elif rotation_degrees.x > max_angle_y:
		rotation_degrees.x = max_angle_y
