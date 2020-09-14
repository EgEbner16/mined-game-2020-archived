extends Equipment

class_name Distributor

func _init():
	self.type = 'distributor'
	resource_handler.power_usage = 5
	resource_handler.coolant_usage = 20
	resource_handler.capital_cost = 5000
