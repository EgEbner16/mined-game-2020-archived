extends Node

class_name EquipmentManager

const MINING_CORE = preload("res://entities/equipment/MiningCore.tscn")

var capital_usage: float = 0.0
var capital_production: float = 0.0

var material_usage: float = 0.0
var material_production: float = 0.0

var power_usage: float = 0.0
var power_production: float = 0.0

var coolant_usage: float = 0.0
var coolant_production: float = 0.0

onready var resource_manager: ResourceManager = get_node('/root/Game/ResourceManager')
onready var resource_handler: ResourceHandler = ResourceHandler.new()

func _ready():
	pass

func create_equipment(type: String, layer: int, world_location: Vector2) -> void:
	var mining_core = MINING_CORE.instance()
	mining_core.add_to_group('equipment')
	mining_core.add_to_group('core_equipment')
	mining_core.position = world_location
	get_node('/root/Game/World/Layer_%s' % layer).add_child(mining_core)


func _on_Timer_timeout():
	resource_handler.reset()
	power_usage = 0.0
	power_production = 0.0
	coolant_usage = 0.0
	coolant_production = 0.0
	for equipment in get_tree().get_nodes_in_group('equipment'):
		power_usage += equipment.power_usage
		power_production += equipment.power_production
		coolant_usage += equipment.coolant_usage
		coolant_production += equipment.coolant_production
		if resource_manager.use_material(equipment.material_usage):
			resource_manager.gain_capital(equipment.capital_production)
	resource_manager.power = power_production
	resource_manager.coolant = coolant_production
