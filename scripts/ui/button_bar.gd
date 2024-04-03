extends HBoxContainer
class_name ButtonToggleBar

func _ready() -> void:
	for child in get_children():
		if child is Button:
			child.toggle_mode = true
			child.pressed.connect(change_current_button.bind(child))

func change_current_button(button : Button) -> void:
	for child in get_children():
		if child is Button:
			if child == button:
				child.button_pressed = true
			else:
				child.button_pressed = false
