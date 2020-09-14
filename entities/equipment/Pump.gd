extends Equipment

class_name Pump

func _init():
	self.type = 'pump'
	resource_handler.power_usage = 20
	resource_handler.coolant_production = 460
	resource_handler.capital_cost = 4000
