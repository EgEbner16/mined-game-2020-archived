extends Equipment


class_name ElevatorUp


var linked_elevator_down


func _init():
	resource_handler.power_usage = 50
	resource_handler.coolant_usage = 10
	resource_handler.capital_cost = 50000
