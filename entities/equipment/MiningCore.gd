extends "res://entities/equipment/Equipment.gd"

class_name MiningCore

func _init():
	resource_handler.power_production = 200
	resource_handler.coolant_production = 100
	resource_handler.material_usage = 800
	resource_handler.capital_production = 120
	resource_handler.capital_cost = 0
