extends Button
class_name InventoryItem

@onready var texture : TextureRect = $vbox/texture
@onready var label : Label = $vbox/lbl

@export var furniture : StockedFurniture

signal selected

func _ready() -> void:
	texture.texture = await MeshPreview.generate_texture_from_scene(
		furniture.furniture,
		Vector2(128,128)
	)
	label.text = str(
		"(",furniture.count,") ",
		furniture.furniture.resource_path.get_file().split(".")[0]
	)
	pressed.connect(select)

func select() -> void:
	Player.current.object_to_place = furniture
	Player.current.editing = true
	selected.emit()
