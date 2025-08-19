extends Node

@export var global_conditions_path: String = "res://global_systems/action_condition_system/conditions/data"
@export var global_state_changers_path: String = "res://global_systems/action_condition_system/state_changers/data"

var global_acs_unit: ACSUnit = ACSUnit.new(global_conditions_path, global_state_changers_path)

func new_unit(conditions_path: String = global_conditions_path, state_changers_path: String = global_state_changers_path):
	return ACSUnit.new(conditions_path, state_changers_path)

func set_action(action: Action, acs_unit: ACSUnit = global_acs_unit):
	_call_state_changers(action, acs_unit)
	_evaluate_conditions(action, acs_unit)

func _call_state_changers(action: Action, acs_unit: ACSUnit):
	for sc in acs_unit.state_changers:
		if sc.type == action.type:
			sc.change_state.call(action)

func _evaluate_conditions(action: Action, acs_unit: ACSUnit):
	for cond in acs_unit.conditions:
		if cond.type == action.type:
			cond.evaluate(action)

func get_condition_by_id(cond_id: String, acs_unit: ACSUnit = global_acs_unit) -> Condition:
		for condition in acs_unit.conditions:
			if condition.id == cond_id:
				return condition
		push_error("No condition with this id:" + cond_id + "register in system")
		return null

class ACSUnit extends Resource:
	var conditions_path: String 
	var state_changers_path: String 
	var conditions: Array[Condition] 
	var state_changers: Array[StateChanger] 
	
	func _init(_conditions_path: String, _state_changers_path: String) -> void:
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
