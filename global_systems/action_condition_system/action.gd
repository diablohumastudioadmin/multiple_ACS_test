class_name Action extends Resource

enum TYPES {LVL_BUYED}

var type: TYPES
var payload: Payload

func _init(_type: TYPES, _payload: Payload, acs_unit: ACS.ACSUnit = ACS.global_acs_unit) -> void:
	type = _type
	payload = _payload
