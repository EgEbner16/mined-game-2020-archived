extends Equipment


class_name Distributor


func _init():
	self.type = 'distributor'
	self.verbose_name = 'Distributor'
	self.verbose_description = 'Reduces the power penalty for units that are working away from the core.'
	resource_handler.power_usage = 5
	resource_handler.coolant_usage = 20
	resource_handler.capital_cost = 5000
