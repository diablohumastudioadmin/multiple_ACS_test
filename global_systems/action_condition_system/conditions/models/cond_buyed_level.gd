class_name CondBuyedLevel extends Condition

@export var buyed_level_id: String

func _init() -> void:
	type = Action.TYPES.LVL_BUYED

func evaluate(action: Action):
	var payload : PayloadBuyedLevel = action.payload as PayloadBuyedLevel
	if payload.buyed_level_id == buyed_level_id:
		fullfilled.emit(self)
