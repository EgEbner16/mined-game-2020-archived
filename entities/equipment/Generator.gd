extends Equipment

class_name Generator

func _ready():
	resource_handler.power_production = 100
	resource_handler.coolant_usage = 20
	resource_handler.material_cost = 5000
