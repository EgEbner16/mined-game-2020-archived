extends Equipment

class_name MatterReactor

func _init():
	resource_handler.power_usage = 50
	resource_handler.coolant_usage = 20
	resource_handler.material_usage = 1600
	resource_handler.capital_production = 240
	resource_handler.capital_cost = 2000
