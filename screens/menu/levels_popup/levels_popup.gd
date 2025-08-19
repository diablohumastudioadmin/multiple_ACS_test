class_name LevelsPopup extends VBoxContainer

var acs_unit: ACS.ACSUnit

func _ready() -> void:
	acs_unit = ACS.new_unit()
	for level_btn in %LevelBtnsContainer.get_children() as Array[LevelBtn]:
		level_btn.acs_unit = acs_unit
		level_btn.change_level_conditions_to_acs_unit()

func _on_close_btn_pressed() -> void:
	queue_free()
