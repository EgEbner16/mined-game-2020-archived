extends "res://entities/equipment/Equipment.gd"

class_name MiningCore

func _init():
	self.type = 'mining_core'
	self.verbose_name = 'Mining Core'
	self.verbose_description = 'Center of your mining operation'
	resource_handler.power_production = 600
	resource_handler.coolant_production = 400
	resource_handler.material_usage = 300
	resource_handler.capital_production = 100
	resource_handler.capital_cost = 0
