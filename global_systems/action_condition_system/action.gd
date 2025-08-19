class_name Action extends Resource

enum TYPES {LVL_BUYED}

var type: TYPES
var payload: Payload

func _init(_type: TYPES, _payload: Payload) -> void:
	type = _type
	payload = _payload
