extends Control

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		var new_popup_pos: Vector2 = event.global_position
		var new_popup: LevelsPopup = load("res://screens/menu/levels_popup/levels_popup.tscn").instantiate()
		new_popup.global_position = new_popup_pos
		add_child(new_popup)
