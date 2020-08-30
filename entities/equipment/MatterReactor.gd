extends Equipment

class_name MatterReactor

func _init():
	resource_handler.power_usage = 50
	resource_handler.coolant_usage = 20
	resource_handler.material_usage = 1000
	resource_handler.capital_production = 300
	resource_handler.capital_cost = 10000
