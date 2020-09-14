extends Equipment


class_name ElevatorUp


var linked_elevator_down_node_path: String


func _init():
	self.type = 'elevator_up'
	resource_handler.power_usage = 50
	resource_handler.coolant_usage = 10
	resource_handler.capital_cost = 50000
