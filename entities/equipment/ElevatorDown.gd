extends Equipment


class_name ElevatorDown


var linked_elevator_up_node_path: String


func _init():
	self.type = 'elevator_down'
	self.verbose_name = 'Elevator'
	self.verbose_description = 'Allows drones to go between layers'
	resource_handler.power_usage = 50
	resource_handler.coolant_usage = 10
	resource_handler.capital_cost = 50000

func _physics_process(delta):
	if constructed < 100.0:
		var linked_elevator_up = get_node(self.linked_elevator_up_node_path)
		linked_elevator_up.constructed = constructed
	else:
		var linked_elevator_up = get_node(self.linked_elevator_up_node_path)
		linked_elevator_up.set_constructed()

