extends Resource
class_name MeshAwaitingPreview

@export var mesh : PackedScene

signal finished

func _init(_mesh : PackedScene) -> void:
	mesh = _mesh
