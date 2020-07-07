extends Node

class_name EquipmentManager

const MINING_CORE = preload("res://entities/equipment/MiningCore.tscn")

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
	for equipment in get_tree().get_nodes_in_group('equipment'):
		resource_handler.add_to_power_and_coolant_pool('equipment', equipment.resource_handler.power_usage, equipment.resource_handler.power_production, equipment.resource_handler.coolant_usage, equipment.resource_handler.coolant_production)
		if resource_manager.use_material(equipment.resource_handler.material_usage):
			resource_manager.gain_capital(equipment.resource_handler.capital_production)
	resource_manager.resource_handler.merge(resource_handler)
