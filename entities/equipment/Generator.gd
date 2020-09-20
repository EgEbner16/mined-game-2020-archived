extends Equipment


class_name Generator


func _init():
	self.type = 'generator'
	self.verbose_name = 'Generator'
	self.verbose_description = 'Consumes coolant to generate power for everything.'
	resource_handler.power_production = 280
	resource_handler.coolant_usage = 20
	resource_handler.capital_cost = 7500
