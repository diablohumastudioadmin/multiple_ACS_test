class_name Level extends Resource

signal just_unlocked

@export var id: String
@export var level_name: String
@export var unlock_conditions: Array[Condition] 

var is_unlocked: bool = false
@export var unlocked_by_default: bool

func get_acs_unit_conditions(acs_unit: ActionConditionSystem):
	for condition in unlock_conditions:
		if condition.fullfilled.is_connected(_on_condition_fullfilled):
			condition.fullfilled.disconnect(_on_condition_fullfilled)

	var new_conditions_array: Array[Condition]
	for condition in unlock_conditions:
		var new_condition: Condition = acs_unit.get_condition_by_id(condition.id)
		new_conditions_array.append(new_condition)
	unlock_conditions = new_conditions_array

	for condition in unlock_conditions:
		if !condition.fullfilled.is_connected(_on_condition_fullfilled):
			condition.fullfilled.connect(_on_condition_fullfilled)

func _on_condition_fullfilled(condition: Condition):
	is_unlocked = true
	just_unlocked.emit()
