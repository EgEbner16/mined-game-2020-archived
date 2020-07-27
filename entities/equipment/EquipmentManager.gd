extends Node

class_name EquipmentManager

const MINING_CORE = preload("res://entities/equipment/MiningCore.tscn")
const GENERATOR = preload("res://entities/equipment/Generator.tscn")

onready var resource_manager: ResourceManager = get_node('/root/Game/ResourceManager')
onready var resource_handler: ResourceHandler = ResourceHandler.new()

var equipment: Dictionary = {
	'mining_core': MiningCore,
	'generator': Generator,
}

func _init():
	pass

func _ready():
	pass

func create_equipment(equipment_name: String, layer: int, world_location: Vector2) -> void:
	var active_layer = get_parent().get_node('Layer_%s' % layer)
	if equipment.has(equipment_name):
		if equipment_name == 'mining_core':
			if create_mining_core(layer, world_location):
				active_layer.tile_manager.set_tile_to_blank(active_layer.tile_manager.world_to_map(world_location))
		if equipment_name == 'generator':
			if create_generator(layer, world_location):
				active_layer.tile_manager.set_tile_to_blank(active_layer.tile_manager.world_to_map(world_location))

func create_mining_core(layer: int, world_location: Vector2) ->  bool:
	var mining_core = MINING_CORE.instance()
	if resource_manager.use_capital(mining_core.resource_handler.capital_cost):
		mining_core.add_to_group('equipment')
		mining_core.add_to_group('core_equipment')
		mining_core.name = 'mining_core'
		mining_core.position = world_location
		get_node('/root/Game/World/Layer_%s' % layer).add_child(mining_core)
		return true
	else:
		return false

func create_generator(layer: int, world_location: Vector2) -> bool:
	print('Building Generator at %s' % world_location)
	var generator = GENERATOR.instance()
	if resource_manager.use_capital(generator.resource_handler.capital_cost):
		generator.add_to_group('equipment')
		generator.add_to_group('power_equipment')
		generator.name = 'generator'
		generator.position = world_location
		get_node('/root/Game/World/Layer_%s' % layer).add_child(generator)
		return true
	else:
		return false

func _on_Timer_timeout():
	resource_handler.reset()
	for equipment in get_tree().get_nodes_in_group('equipment'):
		resource_handler.add_to_power_and_coolant_pool('equipment', equipment.resource_handler.power_usage, equipment.resource_handler.power_production, equipment.resource_handler.coolant_usage, equipment.resource_handler.coolant_production)
		if resource_manager.use_material(equipment.resource_handler.material_usage):
			resource_manager.gain_capital(equipment.resource_handler.capital_production)
	resource_manager.resource_handler.merge(resource_handler)
