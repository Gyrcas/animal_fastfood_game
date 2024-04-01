extends Resource
class_name StockedFurniture

enum FurnitureType{
	chair,
	table
}

@export var count : int = 0

@export var furniture : PackedScene

@export var type : FurnitureType
