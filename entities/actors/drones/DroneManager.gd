extends Node

class_name DroneManager

const MINING_DRONE = preload("res://entities/actors/drones/MiningDrone.tscn")

var power_usage: float = 0.0
var coolant_usage: float = 0.0
	
onready var resource_manager: ResourceManager = get_node('/root/Game/ResourceManager')

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
	power_usage = 0.0
	coolant_usage = 0.0
	for drone in get_tree().get_nodes_in_group('drones'):
		power_usage += drone.power_usage
		coolant_usage += drone.coolant_usage
	resource_manager.power_usage = power_usage
	resource_manager.coolant_usage = coolant_usage
