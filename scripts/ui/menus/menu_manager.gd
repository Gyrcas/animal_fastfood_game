extends Control
class_name MenuManager

signal emptied

signal menu_changed(menu : PackedScene)

func change_menu(menu_scene : PackedScene, empty : bool = false) -> Menu:
	for child in get_children():
		child.queue_free()
	if empty:
		emptied.emit()
		return null
	if !menu_scene:
		return
	var menu : Menu = menu_scene.instantiate()
	add_child(menu)
	menu.navigated.connect(change_menu)
	menu_changed.emit(menu_scene)
	return menu
