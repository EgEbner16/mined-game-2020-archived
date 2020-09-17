extends Node


class_name Destination


var start_position: Vector2
var start_layer_number: int
var end_position: Vector2
var end_layer_number: int
var arrived: bool = true
var steps: Array


func _init():
	pass

func generate_steps(start_position: Vector2, start_layer_number: int, end_position: Vector2, end_layer_number: int):
	self.start_position = start_position
	self.start_layer_number = start_layer_number
	self.end_position = end_position
	self.end_layer_number = end_layer_number
	self.arrived = false
	generate_navigation()

func generate_navigation():
	if start_layer_number == end_layer_number:
		var current_layer = get_node('/root/Game/World/Layer_%s' % start_layer_number)
		self.steps.append(current_layer.get_navigation_path(start_position, end_position))

func get_step():
	if self.steps.size() > 0:
		pass
	else:
		return false
