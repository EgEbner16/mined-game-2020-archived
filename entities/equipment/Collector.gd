extends Equipment


class_name Collector


func _init():
	self.type = 'collector'
	self.verbose_name = 'Collector'
	self.verbose_description = 'Portable place for logistic drones to drop off material.'
	resource_handler.power_usage = 15
	resource_handler.coolant_usage = 5
	resource_handler.capital_cost = 10000

