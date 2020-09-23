extends Equipment


class_name Scanner


func _init():
	self.type = 'scanner'
	self.verbose_name = 'Scanner'
	self.verbose_description = 'Scans the layer (Not Implemented)'
	resource_handler.power_usage = 30
	resource_handler.coolant_usage = 30
	resource_handler.capital_cost = 6000
