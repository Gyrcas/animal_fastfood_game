extends GridContainer
class_name StockedFurnitureUI

var item_scene : PackedScene = preload(
	"res://scenes/ui/inventory_item.tscn"
)

signal item_selected

func reload() -> void:
	for child in get_children():
		child.queue_free()
	for furniture in Restaurant.stocked_furnitures:
		var item : InventoryItem = item_scene.instantiate()
		item.furniture = furniture
		item.selected.connect(emit_item_selected)
		add_child(item)

func emit_item_selected() -> void:
	item_selected.emit(null)

func _ready():
	reload()
