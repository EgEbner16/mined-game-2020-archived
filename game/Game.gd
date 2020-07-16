extends Node2D

onready var hud = $InterfaceManager/HUD

onready var resource_manager: ResourceManager = $ResourceManager
onready var world = $World


func _ready():
	pass
#	$Camera.position = ProjectSettings.get_setting("game/config/world_size") / 2

func _process(delta):
	hud.capital_value = resource_manager.resource_handler.capital
	hud.material_value = resource_manager.resource_handler.material
	hud.power_value = resource_manager.resource_handler.power
	hud.power_usage_value = resource_manager.resource_handler.power_usage
	hud.coolant_value = resource_manager.resource_handler.coolant
	hud.coolant_usage_value = resource_manager.resource_handler.coolant_usage
	var working_drones: int = 0
	for drone in get_tree().get_nodes_in_group('drones'):
		if drone.working:
			working_drones += 1
	hud.drones = get_tree().get_nodes_in_group('drones').size()
	hud.drones_working = working_drones
	hud.equipment = get_tree().get_nodes_in_group('equipment').size()
	hud.jobs = get_tree().get_nodes_in_group('jobs').size()
	hud.layer_number = world.current_active_layer
