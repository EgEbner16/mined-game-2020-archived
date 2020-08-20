extends "res://entities/equipment/Equipment.gd"

class_name MiningCore

func _init():
	resource_handler.power_production = 400
	resource_handler.coolant_production = 400
	resource_handler.material_usage = 300
	resource_handler.capital_production = 100
	resource_handler.capital_cost = 0
