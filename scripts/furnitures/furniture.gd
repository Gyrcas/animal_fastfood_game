extends MeshInstance3D
class_name Furniture

@onready var material : StandardMaterial3D = mesh.surface_get_material(0)

@onready var body : StaticBody3D = $StaticBody3D

@export var color : Color = Color(1,1,1,1) : set = set_color

signal furniture_placed

const cell_size : int = 2

const collision_layer : int = 2

static var furnitures : Dictionary = {}

var pos : Vector2 = Vector2.ZERO

func _ready() -> void:
	body.set_collision_layer_value(1,false)
	body.set_collision_mask_value(1,false)
	body.set_collision_layer_value(collision_layer,true)
	body.set_collision_mask_value(collision_layer,true)
	var nav_mesh : NavigationRegion3D = get_tree().get_first_node_in_group("nav_mesh")
	if nav_mesh:
		furniture_placed.connect(nav_mesh.bake_navigation_mesh)

func move_to(new_pos : Vector3) -> void:
	new_pos = (new_pos / cell_size).floor()
	new_pos += Vector3(0.5,0,0.5)
	new_pos.y = 1
	var p : Vector2 = Vector2(new_pos.z,new_pos.x)
	if furnitures.has(p) && furnitures[p] != null:
		return
	global_position = new_pos * cell_size
	pos = p

func do_rotate(right : bool = false) -> void:
	if right:
		rotation_degrees.y += 90
	else:
		rotation_degrees.y -= 90

func set_color(value : Color) -> void:
	color = value
	mesh.surface_get_material(0).albedo_color = color

func place(place_pos : Vector2) -> void:
	if !furnitures.keys().has(place_pos):
		Restaurant.current.nav.add_child(self)
		furnitures[place_pos] = self
		furniture_placed.emit()
