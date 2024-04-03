extends MenuManager
class_name GameMenuManager

static var current_menu : PackedScene : set = set_current_menu

static func set_current_menu(menu : PackedScene) -> void:
	current_menu = menu

func _ready():
	menu_changed.connect(set_current_menu)
	if current_menu:
		change_menu(current_menu)
