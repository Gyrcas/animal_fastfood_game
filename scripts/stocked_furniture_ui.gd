extends GridContainer
class_name StockedFurnitureUI

func reload() -> void:
	for child in get_children():
		child.queue_free()
	for furniture in Restaurant.stocked_furnitures:
		var button : Button = Button.new()
		button.custom_minimum_size = Vector2(512,512)
		add_child(button)
		var container : VSplitContainer = VSplitContainer.new()
		button.add_child(container)
		var texture : TextureRect = TextureRect.new()
		container.add_child(texture)
		texture.texture = await MeshPreview.generate_texture_from_scene(
			furniture.furniture,
			Vector2(128,128)
		)
		var label : Label = Label.new()
		container.add_child(label)
		label.text = "aaa"

func _ready():
	await get_tree().create_timer(0.5).timeout
	reload()
