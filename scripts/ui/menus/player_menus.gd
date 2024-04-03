extends MenuManager
class_name PlayerMenus

var pause_menu_scene : PackedScene = preload(
	"res://scenes/ui/menus/pause_menu.tscn"
)

var game_menu_scene : PackedScene = preload(
	"res://scenes/ui/menus/game_menu.tscn"
)

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	emptied.connect(on_menu_emptied)

func _input(event : InputEvent) -> void:
	if get_child_count() == 0:
		var menu : Menu
		if event.is_action_pressed("back"):
			menu = change_menu(pause_menu_scene)
		elif event.is_action_pressed("game_menu"):
			menu = change_menu(game_menu_scene)
		if menu:
			get_tree().paused = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func on_menu_emptied() -> void:
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
