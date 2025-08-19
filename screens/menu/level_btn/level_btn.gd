@tool
class_name LevelBtn extends Button

@export var level: Level : set = _set_level

var acs_unit: ActionConditionSystem: set = _set_acs_unit

func _set_acs_unit(new_value: ActionConditionSystem):
	acs_unit = new_value
	level.get_acs_unit_conditions(acs_unit)

func _set_level(new_value: Level):
	level = new_value.duplicate()
	if Engine.is_editor_hint() and new_value != null:
		_set_text_and_colors()

func _on_level_just_unlocked():
	_set_text_and_colors()

func _ready() -> void:
	level.just_unlocked.connect(_on_level_just_unlocked)
	_set_text_and_colors()

func _set_text_and_colors():
	text = level.level_name
	if !level.is_unlocked and !level.unlocked_by_default:
		disabled = true
	else:
		disabled = false
		modulate = Color.GREEN

func _on_pressed() -> void:
	acs_unit.set_action(Action.new(Action.TYPES.LVL_BUYED, PayloadBuyedLevel.new(level.id)))
