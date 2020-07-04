extends Node

class_name StateManager

var states
var current_state

func _init():
	states = {
		"idle": StateIdle,
		"moving": StateMoving,
	}
	
func get_state(state_name):
	if states.has(state_name):
		current_state = state_name
		return states.get(state_name)
	else:
		printerr("No state %s in state manager" % state_name)
