class_name ActionConditionSystem extends Node

var global_conditions_path: String = "res://global_systems/action_condition_system/conditions/data"
var global_state_changers_path: String = "res://global_systems/action_condition_system/state_changers/data"

var conditions_path: String 
var state_changers_path: String 
var conditions: Array[Condition] 
var state_changers: Array[StateChanger] 

func _init(_conditions_path: String = global_conditions_path, _state_changers_path: String = global_state_changers_path) -> void:
	conditions_path = _conditions_path
	state_changers_path = _state_changers_path
	conditions = _load_conditions_from_disk()
	state_changers = _load_state_changers_from_disk()

func _load_conditions_from_disk() -> Array[Condition]:
	var conds: Array[Condition]
	var dir := DirAccess.open(conditions_path)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var cond: Condition = load(dir.get_current_dir() + "/" + file)
		assert(cond != null, "Failed to load condition: " + file)
		conds.append(cond.duplicate())
	return conds

func _load_state_changers_from_disk() -> Array[StateChanger]:
	var state_changers_array: Array[StateChanger]
	var dir := DirAccess.open(state_changers_path)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var state_changer: StateChanger = load(dir.get_current_dir() + "/" + file)
		assert(state_changer != null, "Failed to load state_changer: " + file)
		state_changers_array.append(state_changer.duplicate())
	return state_changers_array

func set_action(action: Action):
	_call_state_changers(action)
	_evaluate_conditions(action)

func _call_state_changers(action: Action):
	for sc in state_changers:
		if sc.type == action.type:
			sc.change_state.call(action)

func _evaluate_conditions(action: Action):
	for cond in conditions:
		if cond.type == action.type:
			cond.evaluate(action)

func get_condition_by_id(cond_id: String) -> Condition:
		for condition in conditions:
			if condition.id == cond_id:
				return condition
		push_error("No condition with this id:" + cond_id + "register in system")
		return null
