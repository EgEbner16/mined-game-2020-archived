extends Equipment

class_name MatterReactor

func _init():
	self.type = 'matter_reactor'
	self.verbose_name = 'Matter Reactor'
	self.verbose_description = 'Converts material into capital'
	resource_handler.power_usage = 50
	resource_handler.coolant_usage = 20
	resource_handler.material_usage = 1300
	resource_handler.capital_production = 400
	resource_handler.capital_cost = 10000
