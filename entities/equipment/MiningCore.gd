extends "res://entities/equipment/Equipment.gd"

func _ready():
	resource_handler.power_production = 200
	resource_handler.coolant_production = 100
	resource_handler.material_usage = 800
	resource_handler.capital_production = 120
