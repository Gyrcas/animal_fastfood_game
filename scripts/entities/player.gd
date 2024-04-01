extends CharacterBody3D
class_name Player

@onready var camera_pivot : Node3D = $camera_pivot

@onready var camera : Camera3D = $camera_pivot/camera

@onready var click_ray : RayCast3D = $camera_pivot/camera/click_ray

@export var player_model : Node3D

@export var speed : float = 8

@export var gravity : float = 5

@export var cam_force_mult : float = 1

@export var cam_min_force : float = 0.5

@export var cam_max_angle_up :float = 90

@export var cam_max_angle_down : float = 25

static var placing_object : Furniture

var anim_player : AnimationPlayer

var last_dir : Vector2 = Vector2.ZERO

var editing : bool = false : set = set_editing

func set_editing(value : bool) -> void:
	editing = value
	set_collision_mask_value(Furniture.collision_layer,!editing)
 
func _ready() -> void:
	set_editing(true)
	if player_model.get_parent() != self:
		player_model.reparent(self)
		return
	
	anim_player = player_model.get_node("AnimationPlayer")
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	click_ray.add_exception(self)

func _physics_process(_delta : float) -> void:
	var move_z : float = Input.get_axis("backward","forward")
	var move_x : float = Input.get_axis("right","left")
	
	var dir_z : Vector3 = Vector3(0,0,1).rotated(Vector3(0,1,0),camera_pivot.rotation.y)
	
	var dir_x : Vector3 = dir_z.rotated(Vector3(0,1,0),deg_to_rad(90))
	
	var cur_speed : float = speed
	
	if move_x && move_z:
		cur_speed /= 1.5
	
	velocity = (
		dir_z * move_z +
		dir_x * move_x
	) * cur_speed
	
	if velocity:
		rotate_player_model()
		anim_player.play("Run",0.5)
	else:
		anim_player.play("Idle",0.5)
	
	if click_ray.is_colliding() && placing_object:
		pass
		#placing_object.move_to(click_ray.get_collision_point())
	
	if !is_on_floor():
		velocity.y -= gravity
	
	move_and_slide()
	
func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_camera(event)
	elif event.is_action_pressed("click"):
		if placing_object:
			placing_object.place()
			placing_object = null
			var new_object : MeshInstance3D = load("res://scenes/furnitures/tables/table.tscn").instantiate()
			get_node("../nav").add_child(new_object)
			placing_object = new_object

func rotate_player_model() -> void:
	var target_angle : float = rad_to_deg(atan2(velocity.x,velocity.z))
	var diff : float = target_angle - player_model.rotation_degrees.y
	if diff > 180:
		player_model.rotation_degrees.y += 360
	elif diff < -180:
		player_model.rotation_degrees.y -= 360
	player_model.rotation_degrees.y = lerp(
		player_model.rotation_degrees.y, 
		target_angle,
		0.1
	)

func rotate_camera(event : InputEventMouseMotion) -> void:	
	var force_x : float = -event.relative.x * cam_force_mult
	var force_y : float = -event.relative.y * cam_force_mult
	
	if abs(force_x) < cam_min_force:
		force_x = 0
	if abs(force_y) < cam_min_force:
		force_y = 0
	
	camera_pivot.rotation_degrees.y += force_x
	
	camera_pivot.rotation_degrees.x += force_y
	
	if camera_pivot.rotation_degrees.x < -cam_max_angle_down:
		camera_pivot.rotation_degrees.x = -cam_max_angle_down
	elif camera_pivot.rotation_degrees.x > cam_max_angle_up:
		camera_pivot.rotation_degrees.x = cam_max_angle_up
