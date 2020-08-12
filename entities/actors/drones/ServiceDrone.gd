extends Actor

class_name ServiceDrone

func _init():
	resource_handler.capital_cost = 5000
	base_resource_handler.power_usage = 5
	base_resource_handler.coolant_usage = 2

func _ready():
	self.drone = true
