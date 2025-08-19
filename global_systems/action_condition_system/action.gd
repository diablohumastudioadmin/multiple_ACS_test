class_name Action extends Resource

enum TYPES {LVL_BUYED}

var type: TYPES
var payload: ActionPayload

func _init(_type: TYPES, _payload: ActionPayload) -> void:
	type = _type
	payload = _payload
