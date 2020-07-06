extends Object

class_name ResourceHandler

var capital: float = 0.0
var capital_usage: float = 0.0
var capital_production: float = 0.0

var material: float = 0.0
var material_usage: float = 0.0
var material_production: float = 0.0

var power: float = 0.0
var power_usage: float = 0.0
var power_production: float = 0.0

var coolant: float = 0.0
var coolant_usage: float = 0.0
var coolant_production: float = 0.0

func _init():
	pass

func merge(resource_handler: ResourceHandler) -> void:
	capital += resource_handler.capital
	capital_usage += resource_handler.capital_usage
	capital_production += resource_handler.capital_production

	material += resource_handler.material
	material_usage += resource_handler.material_usage
	material_production += resource_handler.material_production

	power += resource_handler.power
	power_usage += resource_handler.power_usage
	power_production += resource_handler.power_production

	coolant += resource_handler.coolant
	coolant_usage += resource_handler.coolant_usage
	coolant_production += resource_handler.coolant_production

func reset():
	capital = 0.0
	capital_usage = 0.0
	capital_production = 0.0

	material = 0.0
	material_usage = 0.0
	material_production = 0.0

	power = 0.0
	power_usage = 0.0
	power_production = 0.0

	coolant = 0.0
	coolant_usage = 0.0
	coolant_production = 0.0
