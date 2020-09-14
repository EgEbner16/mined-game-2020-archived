extends Equipment

class_name MatterReactor

func _init():
	self.type = 'matter_reactor'
	resource_handler.power_usage = 50
	resource_handler.coolant_usage = 20
	resource_handler.material_usage = 2000
	resource_handler.capital_production = 600
	resource_handler.capital_cost = 10000
