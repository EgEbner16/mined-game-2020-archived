extends Actor

class_name LogisticDrone

func _init():
	resource_handler.capital_cost = 500
	resource_handler.power_usage = 5
	resource_handler.coolant_usage = 2

func _ready():
	pass
