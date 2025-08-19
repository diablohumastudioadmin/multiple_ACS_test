class_name Condition extends Resource

@warning_ignore("unused_signal")
signal fullfilled(cond: Condition)

#@export var id: String

var type: Action.TYPES

@warning_ignore("unused_parameter")
func evaluate(action: Action):
	printerr("Condition.evaluate() must be overridden in subclasses")
	pass
