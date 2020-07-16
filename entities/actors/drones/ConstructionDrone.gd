extends Actor

class_name ConstructionDrone

func _init():
	resource_handler.capital_cost = 5000
	resource_handler.power_usage = 5
	resource_handler.coolant_usage = 2

func _ready():
	pass
