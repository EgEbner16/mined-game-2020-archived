extends Node

class_name DroneManager

const MINING_DRONE = preload("res://entities/actors/drones/MiningDrone.tscn")
const SERVICE_DRONE = preload("res://entities/actors/drones/ServiceDrone.tscn")
const CONSTRUCTION_DRONE = preload("res://entities/actors/drones/ConstructionDrone.tscn")
const LOGISTIC_DRONE = preload("res://entities/actors/drones/LogisticDrone.tscn")

onready var resource_manager: ResourceManager = get_node('/root/Game/ResourceManager')
onready var resource_handler: ResourceHandler = ResourceHandler.new()

func _ready():
	pass # Replace with function body.

func create_drone(type: String, layer: int) -> void:
	var mining_core: Equipment = get_node('/root/Game/World/Layer_0/mining_core')
	if type == 'mining':
		var mining_drone = MINING_DRONE.instance()
		if resource_manager.use_capital(mining_drone.resource_handler.capital_cost):
			mining_drone.add_to_group('drones')
			mining_drone.add_to_group('mining_drones')
			mining_drone.position = Vector2(mining_core.position.x + randi() % 132 - 50, mining_core.position.y + randi() % 132 - 50)
			get_node('/root/Game/World/Layer_%s' % layer).add_child(mining_drone)
		else:
			mining_drone.queue_free()
	if type == 'service':
		var service_drone = SERVICE_DRONE.instance()
		if resource_manager.use_capital(service_drone.resource_handler.capital_cost):
			service_drone.add_to_group('drones')
			service_drone.add_to_group('service_drones')
			service_drone.position = Vector2(mining_core.position.x + randi() % 132 - 50, mining_core.position.y + randi() % 132 - 50)
			get_node('/root/Game/World/Layer_%s' % layer).add_child(service_drone)
		else:
			service_drone.queue_free()
	if type == 'construction':
		var construction_drone = CONSTRUCTION_DRONE.instance()
		if resource_manager.use_capital(construction_drone.resource_handler.capital_cost):
			construction_drone.add_to_group('drones')
			construction_drone.add_to_group('construction_drones')
			construction_drone.position = Vector2(mining_core.position.x + randi() % 132 - 50, mining_core.position.y + randi() % 132 - 50)
			get_node('/root/Game/World/Layer_%s' % layer).add_child(construction_drone)
		else:
			construction_drone.queue_free()
	if type == 'logistic':
		var logistic_drone = LOGISTIC_DRONE.instance()
		if resource_manager.use_capital(logistic_drone.resource_handler.capital_cost):
			logistic_drone.add_to_group('drones')
			logistic_drone.add_to_group('logistic_drones')
			logistic_drone.position = Vector2(mining_core.position.x + randi() % 132 - 50, mining_core.position.y + randi() % 132 - 50)
			get_node('/root/Game/World/Layer_%s' % layer).add_child(logistic_drone)
		else:
			logistic_drone.queue_free()


func _on_Timer_timeout():
	resource_handler.reset()
	for drone in get_tree().get_nodes_in_group('drones'):
		resource_handler.add_to_power_and_coolant_pool('drone', drone.resource_handler.power_usage, drone.resource_handler.power_production, drone.resource_handler.coolant_usage, drone.resource_handler.coolant_production)
	resource_manager.resource_handler.merge(resource_handler)
