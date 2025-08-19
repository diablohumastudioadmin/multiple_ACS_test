extends VBoxContainer

var acs_unit: ACS.ACSUnit

func _ready() -> void:
	acs_unit = ACS.new_unit()
	for level_btn in get_children() as Array[LevelBtn]:
		level_btn.acs_unit = acs_unit
