extends Equipment

class_name Pump

func _init():
	self.type = 'pump'
	self.verbose_name = 'Pump'
	self.verbose_description = 'Consumes power to create coolant'
	resource_handler.power_usage = 10
	resource_handler.coolant_production = 460
	resource_handler.capital_cost = 4000
