extends Control
class_name Menu

signal navigated(menu : PackedScene, empty : bool)

@export_file("*.tscn") var back_menu : String

@export var empty_on_back : bool = false

func navigate(menu : PackedScene = null) -> void:
	navigated.emit(menu, !menu)

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("back"):
		if back_menu:
			navigated.emit(load(back_menu), empty_on_back)
		else:
			navigated.emit(null, empty_on_back)
