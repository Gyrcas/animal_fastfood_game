extends Node3D
class_name Restaurant

static var stocked_furnitures : Array[StockedFurniture] = []

func _ready() -> void:
	var e = StockedFurniture.new()
	e.count = 5
	e.furniture = load("res://scenes/furnitures/tables/table.tscn")
	
	stocked_furnitures.append(e)
	
	e = StockedFurniture.new()
	
	e.count = 3
	e.furniture = load("res://scenes/furnitures/chairs/bench.tscn")
	
	stocked_furnitures.append(e)
