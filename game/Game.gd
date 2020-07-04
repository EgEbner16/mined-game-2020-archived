extends Node2D

onready var hud = $HUD
onready var resource_manager: ResourceManager = $ResourceManager

func _ready():
	var options_menu = load("res://menus/OptionsMenu.tscn")
	add_child(options_menu.instance())
#	$Camera.position = ProjectSettings.get_setting("game/config/world_size") / 2


func _process(delta):
	hud.capital_value = resource_manager.capital
	hud.material_value = resource_manager.material
	hud.power_value = resource_manager.power
	hud.coolant_value = resource_manager.coolant
	var working_drones: int = 0
	for drone in get_tree().get_nodes_in_group('drones'):
		if drone.working:
			working_drones += 1
	hud.drones = get_tree().get_nodes_in_group('drones').size()
	hud.drones_working = working_drones
	hud.equipment = get_tree().get_nodes_in_group('equipment').size()
	hud.jobs = get_tree().get_nodes_in_group('jobs').size()
	if Input.is_action_just_released("display_options"):
		$OptionsMenu.open()
