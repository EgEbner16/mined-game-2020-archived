extends Node2D

class_name Game

onready var hud = $InterfaceManager/HUD
onready var resource_manager: ResourceManager = $ResourceManager
onready var world: GameWorld = $World

var game_speed_minimum = 0.5
var game_speed_maximum = 3.0
var game_current_speed = 1.0
var game_speed = 1.0

func _ready():
	pass
#	$Camera.position = ProjectSettings.get_setting("game/config/world_size") / 2

func _input(event):
	if event.is_action_released("game_speed_pause"):
		if get_tree().paused:
			get_tree().paused = false
			hud.game_speed_hud_value.text = 'Normal'
		else:
			get_tree().paused = true
			hud.game_speed_hud_value.text = 'Paused'
	if event is InputEventKey:
		if event.scancode == KEY_M:
			pass
#			resource_manager.gain_capital(1000)

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
