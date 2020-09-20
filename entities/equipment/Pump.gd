extends Equipment

class_name Pump

func _init():
	self.type = 'pump'
	self.verbose_name = 'Pump'
	self.verbose_description = 'Provides coolant to all drones and equipment.'
	resource_handler.power_usage = 20
	resource_handler.coolant_production = 460
	resource_handler.capital_cost = 4000
