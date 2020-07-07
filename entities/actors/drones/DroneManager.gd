extends Node

class_name DroneManager

const MINING_DRONE = preload("res://entities/actors/drones/MiningDrone.tscn")

onready var resource_manager: ResourceManager = get_node('/root/Game/ResourceManager')

onready var resource_handler: ResourceHandler = ResourceHandler.new()

func _ready():
	pass # Replace with function body.

func create_drone(type: String, layer: int, world_location: Vector2) -> void:
	if resource_manager.use_capital(1000):
		var mining_drone = MINING_DRONE.instance()
		mining_drone.add_to_group('drones')
		mining_drone.add_to_group('mining_drones')
		mining_drone.position = world_location
		get_node('/root/Game/World/Layer_%s' % layer).add_child(mining_drone)


func _on_Timer_timeout():
	resource_handler.reset()
	for drone in get_tree().get_nodes_in_group('drones'):
		resource_handler.add_to_power_and_coolant_pool('drone', drone.resource_handler.power_usage, drone.resource_handler.power_production, drone.resource_handler.coolant_usage, drone.resource_handler.coolant_production)
	resource_manager.resource_handler.merge(resource_handler)
