class_name Level extends Resource

signal just_unlocked

@export var id: String
@export var level_name: String
@export var unlock_conditions: Array[Condition] : set = _set_unlock_conditions

var is_unlocked: bool = false
@export var unlocked_by_default: bool

func _set_unlock_conditions(new_value: Array[Condition]):
	for condition in new_value:
		var new_condition: Condition = ACS.get_condition_by_id(condition.id)
		unlock_conditions.append(new_condition)

	for condition in unlock_conditions:
		if !condition.fullfilled.is_connected(_on_condition_fullfilled):
			condition.fullfilled.connect(_on_condition_fullfilled)

func _on_condition_fullfilled(condition: Condition):
	is_unlocked = true
	just_unlocked.emit()
