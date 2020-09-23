extends Equipment


class_name Collector


func _init():
	self.type = 'collector'
	self.verbose_name = 'Collector'
	self.verbose_description = 'Drop off point for logistic drones'
	resource_handler.power_usage = 15
	resource_handler.coolant_usage = 5
	resource_handler.capital_cost = 10000

