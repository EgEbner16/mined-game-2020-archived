extends Equipment


class_name Generator


func _init():
	self.type = 'generator'
	resource_handler.power_production = 280
	resource_handler.coolant_usage = 20
	resource_handler.capital_cost = 7500
