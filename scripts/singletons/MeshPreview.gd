extends Node

var viewport : SubViewport

func _ready() -> void:
	add_child(
		load("res://scenes/mesh_preview_viewport.tscn").instantiate()
	)
	viewport = get_node("mesh_preview_viewport")

func generate_texture_from_scene(packed_scene : PackedScene, size : Vector2 = viewport.size) -> ImageTexture:
	viewport.size = size
	var scene : MeshInstance3D = packed_scene.instantiate()
	viewport.add_child(scene)
	scene.rotation_degrees.y = 45
	await get_tree().process_frame
	var texture : ImageTexture = ImageTexture.create_from_image(
		viewport.get_texture().get_image()
	)
	scene.free()
	return texture
