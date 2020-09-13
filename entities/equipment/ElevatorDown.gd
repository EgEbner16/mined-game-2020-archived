extends Equipment


class_name ElevatorDown


var linked_elevator_up


func _init():
	self.type = 'elevator'
	self.verbose_name = 'Elevator'
	self.verbose_description = 'Allows drones to go between layers'
	resource_handler.power_usage = 50
	resource_handler.coolant_usage = 10
	resource_handler.capital_cost = 50000
