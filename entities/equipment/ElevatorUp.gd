extends Equipment


class_name ElevatorUp


var linked_elevator_down_node_path: String


func _init():
	self.type = 'elevator_up'
	self.verbose_name = 'Elevator Up'
	self.verbose_description = 'Allows drones to go between layers'
	resource_handler.power_usage = 50
	resource_handler.coolant_usage = 10
	resource_handler.capital_cost = 50000
