extends Button
class_name NavigationButton

signal navigated(target : PackedScene)

@export var _target : PackedScene

func _ready() -> void:
	pressed.connect(navigate)

func navigate() -> void:
	navigated.emit(_target)

