extends Object

class_name ResourceHandler

var capital: float = 0.0
var capital_usage: float = 0.0
var capital_production: float = 0.0
var capital_cost: float = 0.0

var material: float = 0.0
var material_usage: float = 0.0
var material_production: float = 0.0

var power: float = 0.0
var power_usage: float = 0.0
var power_usage_percentage: float = 0.0
var power_production: float = 0.0

var power_usage_pool: Dictionary
var power_production_pool: Dictionary

var coolant: float = 0.0
var coolant_usage: float = 0.0
var coolant_usage_percentage: float = 0.0
var coolant_production: float = 0.0

var coolant_usage_pool: Dictionary
var coolant_production_pool: Dictionary

func _init():
	pass

func add_to_coolant_pool(key: String, usage: float, production: float) -> void:
	if key in coolant_usage_pool:
		coolant_usage_pool[key] += usage
		coolant_production_pool[key] += production
	else:
		coolant_usage_pool[key] = usage
		coolant_production_pool[key] = production

func add_to_power_pool(key: String, usage: float, production: float) -> void:
	if key in power_usage_pool:
		power_usage_pool[key] += usage
		power_production_pool[key] += production
	else:
		power_usage_pool[key] = usage
		power_production_pool[key] = production

func add_to_power_and_coolant_pool(key: String, power_usage: float, power_production: float, coolant_usage: float, coolant_production: float) -> void:
	add_to_power_pool(key, power_usage, power_production)
	add_to_coolant_pool(key, coolant_usage, coolant_production)

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

	for key in resource_handler.power_usage_pool:
		power_usage_pool[key] = resource_handler.power_usage_pool[key]

	for key in resource_handler.power_production_pool:
		power_production_pool[key] = resource_handler.power_production_pool[key]

	coolant += resource_handler.coolant
	coolant_usage += resource_handler.coolant_usage
	coolant_production += resource_handler.coolant_production

	for key in resource_handler.coolant_usage_pool:
		coolant_usage_pool[key] = resource_handler.coolant_usage_pool[key]

	for key in resource_handler.coolant_production_pool:
		coolant_production_pool[key] = resource_handler.coolant_production_pool[key]

func calculate_power_and_coolant():

	power = 0.0
	power_usage = 0.0
	power_usage_percentage = 0.0
	power_production = 0.0

	for key in power_usage_pool:
		power_usage += power_usage_pool[key]

	for key in power_production_pool:
		power += power_production_pool[key]
		power_production += power_production_pool[key]

	power_usage_percentage = (power_usage / power) * 100

	coolant = 0.0
	coolant_usage = 0.0
	coolant_usage_percentage = 0.0
	coolant_production = 0.0

	for key in coolant_usage_pool:
		coolant_usage += coolant_usage_pool[key]

	for key in coolant_production_pool:
		coolant += coolant_production_pool[key]
		coolant_production += coolant_production_pool[key]

	coolant_usage_percentage = (coolant_usage / coolant) * 100

func reset():
	capital = 0.0
	capital_usage = 0.0
	capital_production = 0.0
	capital_cost = 0.0

	material = 0.0
	material_usage = 0.0
	material_production = 0.0

	power = 0.0
	power_usage = 0.0
	power_production = 0.0

	power_usage_pool.clear()
	power_production_pool.clear()

	coolant = 0.0
	coolant_usage = 0.0
	coolant_production = 0.0

	coolant_usage_pool.clear()
	coolant_production_pool.clear()
