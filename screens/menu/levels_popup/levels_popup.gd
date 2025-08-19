class_name LevelsPopup extends VBoxContainer

var acs_unit: ActionConditionSystem

func _ready() -> void:
	acs_unit = ActionConditionSystem.new()
	for level_btn in %LevelBtnsContainer.get_children() as Array[LevelBtn]:
		level_btn.acs_unit = acs_unit

func _on_close_btn_pressed() -> void:
	queue_free()
