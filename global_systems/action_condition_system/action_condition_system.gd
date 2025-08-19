class_name ACSs extends Node

@export var global_conditions_path: String = "res://global_systems/action_condition_system/conditions/data"
@export var global_state_changers_path: String = "res://global_systems/action_condition_system/state_changers/data"

var conditions: Array[Condition] = _load_conditions_from_disk()
var state_changers: Array[StateChanger] = _load_state_changers_from_disk()

func _load_conditions_from_disk() -> Array[Condition]:
	var conds: Array[Condition]
	var dir := DirAccess.open(global_conditions_path)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var cond: Condition = load(dir.get_current_dir() + "/" + file)
		assert(cond != null, "Failed to load condition: " + file)
		conds.append(cond)
	return conds

func get_condition_by_id(cond_id: String) -> Condition:
	for condition in conditions:
		if condition.id == cond_id:
			return condition
	push_error("No condition with this id:" + cond_id + "register in system")
	return null
	
func _load_state_changers_from_disk() -> Array[StateChanger]:
	var state_changers_array: Array[StateChanger]
	var dir := DirAccess.open(global_state_changers_path)
	assert(dir != null, "Could not open folder")
	dir.list_dir_begin()
	for file: String in dir.get_files():
		var state_changer: StateChanger = load(dir.get_current_dir() + "/" + file)
		assert(state_changer != null, "Failed to load state_changer: " + file)
		state_changers_array.append(state_changer)
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
