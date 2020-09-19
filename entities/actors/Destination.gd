extends Node


class_name Destination


onready var equipment_manager: EquipmentManager = get_node('/root/Game/World/EquipmentManager')


var start_position: Vector2
var start_layer_number: int
var end_position: Vector2
var end_layer_number: int
var steps_action: Array
var steps_data: Array


func _init():
	pass


func generate_steps(start_position: Vector2, start_layer_number: int, end_position: Vector2, end_layer_number: int):
	self.steps_action.empty()
	self.steps_data.empty()
	self.start_position = start_position
	self.start_layer_number = start_layer_number
	self.end_position = end_position
	self.end_layer_number = end_layer_number
	generate_navigation()


func generate_navigation():
	# Get a Path
	if start_layer_number == end_layer_number:
		var current_layer = get_node('/root/Game/World/Layer_%s' % start_layer_number)
		self.steps_action.append('path')
		self.steps_data.append(current_layer.get_navigation_path(start_position, end_position))
	else:
		var nearest_elevator
		var step_position = self.start_position
		var step_layer
		# Moving Up
		if start_layer_number > end_layer_number:
			for i in range(start_layer_number, end_layer_number, -1):
				step_layer = get_node('/root/Game/World/Layer_%s' % i)
				if equipment_manager.is_equipment(step_layer, 'elevator_up'):
					print('up')
					nearest_elevator = get_node(equipment_manager.get_closest_equipment(step_position, step_layer, 'elevator_up'))
					self.steps_action.append('path')
					self.steps_data.append(step_layer.get_navigation_path(step_position, nearest_elevator.position))
					self.steps_action.append('elevator')
					self.steps_data.append(nearest_elevator.get_path())
					step_position = nearest_elevator.position

		# Moving Down
		if start_layer_number < end_layer_number:
			for i in range(start_layer_number, end_layer_number, 1):
				step_layer = get_node('/root/Game/World/Layer_%s' % i)
				if equipment_manager.is_equipment(step_layer, 'elevator_down'):
					print('down')
					nearest_elevator = get_node(equipment_manager.get_closest_equipment(step_position, step_layer, 'elevator_down'))
					self.steps_action.append('path')
					self.steps_data.append(step_layer.get_navigation_path(step_position, nearest_elevator.position))
					self.steps_action.append('elevator')
					self.steps_data.append(nearest_elevator.get_path())
					step_position = nearest_elevator.position


func get_step():
	var step: Dictionary
	if self.steps_action.size() > 0:
		step = {'action': self.steps_action[0], 'data': self.steps_data[0]}
		self.steps_action.remove(0)
		self.steps_data.remove(0)
#		print('Size: %s' % self.steps_action.size())
	else:
		step =  {'action': 'arrived', 'data': true}
	return step


func has_step():
	if self.steps_action.size() > 0:
		return true
