extends Node3D
class_name Restaurant

@onready var nav : NavigationRegion3D = $nav

static var current : Restaurant

static var in_edit : bool = false

static var stocked_furnitures : Array[StockedFurniture] = []

func _ready() -> void:
	current = self
	
	var e = StockedFurniture.new()
	e.count = 5
	e.furniture = load("res://scenes/furnitures/tables/table.tscn")
	
	stocked_furnitures.append(e)
	
	e = StockedFurniture.new()
	
	e.count = 3
	e.furniture = load("res://scenes/furnitures/chairs/bench.tscn")
	
	stocked_furnitures.append(e)
