extends Node


class_name EquipmentManager


const MINING_CORE = preload("res://entities/equipment/MiningCore.tscn")
const GENERATOR = preload("res://entities/equipment/Generator.tscn")
const COLLECTOR = preload("res://entities/equipment/Collector.tscn")
const MATTER_REACTOR = preload("res://entities/equipment/MatterReactor.tscn")
const DISTRIBUTOR = preload("res://entities/equipment/Distributor.tscn")
const PUMP  = preload("res://entities/equipment/Pump.tscn")
const SCANNER = preload("res://entities/equipment/Scanner.tscn")
const ELEVATOR_DOWN = preload("res://entities/equipment/ElevatorDown.tscn")
const ELEVATOR_UP = preload("res://entities/equipment/ElevatorUp.tscn")


onready var resource_manager: ResourceManager = get_node('/root/Game/ResourceManager')
onready var resource_handler: ResourceHandler = ResourceHandler.new()
onready var job_manager: JobManager = get_node('/root/Game/World/JobManager')
onready var research_manager: ResearchManager = get_node('/root/Game/ResearchManager')


var equipment: Dictionary = {
	'collector': Collector,
	'distributor': Distributor,
	'mining_core': MiningCore,
	'generator': Generator,
	'matter_reactor': MatterReactor,
	'pump': Pump,
	'scanner': Scanner,
	'elevator': ElevatorDown,
}


func _init():
	pass


func _ready():
	pass


func get_closest_equipment(world_location: Vector2, layer, type: String, equipment_is_on: bool = true):
	if self.equipment.has(type):
		var equipment_distance_list: Dictionary
		for equipment in get_tree().get_nodes_in_group('%s_equipment' % type):
			if equipment.entity.on or not equipment_is_on:
				equipment_distance_list[world_location.distance_squared_to(equipment.position)] = equipment.get_path()
		var distance_array: Array = equipment_distance_list.keys()
		distance_array.sort()
		var equipment_closest: String
		equipment_closest = equipment_distance_list[distance_array[0]]
		return equipment_closest


func get_closest_equipment_list(world_location: Vector2, layer, type: String, equipment_is_on: bool = true):
	if self.equipment.has(type):
		var equipment_distance_list: Dictionary
		for equipment in get_tree().get_nodes_in_group('%s_equipment' % type):
			if equipment.entity.on or not equipment_is_on:
				equipment_distance_list[world_location.distance_squared_to(equipment.position)] = equipment.get_path()
		var distance_array: Array = equipment_distance_list.keys()
		distance_array.sort()
		var equipment_closest_list: Dictionary
		for distance in distance_array:
			equipment_closest_list[distance] = equipment_distance_list[distance]
#			print(equipment_distance_list[distance])
		return equipment_closest_list


func get_distance_to_closest_equipment(world_location: Vector2, layer, type: String, equipment_is_on: bool = true) -> float:
	var distance: float = 2000.00
	if self.equipment.has(type):
		for equipment in get_tree().get_nodes_in_group('%s_equipment' % type):
			if equipment.entity.on or not equipment_is_on:
				var distance_to_equipment: float = world_location.distance_squared_to(equipment.position)
				if distance_to_equipment < distance:
					distance = distance_to_equipment
		return distance
	else:
		return distance


func create_equipment(equipment_name: String, layer: int, world_location: Vector2) -> bool:
	var active_layer = get_parent().get_node('Layer_%s' % layer)
	if equipment.has(equipment_name):
		if equipment_name == 'mining_core':
			if create_mining_core(world_location, active_layer):
				active_layer.tile_manager.set_tile_to_blank(active_layer.tile_manager.world_to_map(world_location))
				return true
			else:
				return false
		elif equipment_name == 'generator':
			if create_generator(world_location, active_layer):
				active_layer.tile_manager.set_tile_to_blank(active_layer.tile_manager.world_to_map(world_location))
				return true
			else:
				return false
		elif equipment_name == 'collector':
			if create_collector(world_location, active_layer):
				active_layer.tile_manager.set_tile_to_blank(active_layer.tile_manager.world_to_map(world_location))
				return true
			else:
				return false
		elif equipment_name == 'distributor':
			if create_distributor(world_location, active_layer):
				active_layer.tile_manager.set_tile_to_blank(active_layer.tile_manager.world_to_map(world_location))
				return true
			else:
				return false
		elif equipment_name == 'matter_reactor':
			if create_matter_reactor(world_location, active_layer):
				active_layer.tile_manager.set_tile_to_blank(active_layer.tile_manager.world_to_map(world_location))
				return true
			else:
				return false
		elif equipment_name == 'pump':
			if create_pump(world_location, active_layer):
				active_layer.tile_manager.set_tile_to_blank(active_layer.tile_manager.world_to_map(world_location))
				return true
			else:
				return false
		elif equipment_name == 'scanner':
			if create_scanner(world_location, active_layer):
				active_layer.tile_manager.set_tile_to_blank(active_layer.tile_manager.world_to_map(world_location))
				return true
			else:
				return false
		elif equipment_name == 'elevator':
			if create_elevator(world_location, active_layer):
				active_layer.tile_manager.set_tile_to_blank(active_layer.tile_manager.world_to_map(world_location))
				return true
			else:
				return false
		else:
			return false
	else:
		return false

func create_mining_core(world_location: Vector2, layer) ->  bool:
	var mining_core = MINING_CORE.instance()
	if resource_manager.use_capital(mining_core.resource_handler.capital_cost):
		mining_core.add_to_group('equipment')
		mining_core.add_to_group('core_equipment')
		mining_core.add_to_group('distributor_equipment')
		mining_core.add_to_group('collector_equipment')
		mining_core.name = 'mining_core'
		mining_core.position = world_location
		get_node('/root/Game/World/Layer_%s' % layer.number).add_child(mining_core)
		mining_core.set_constructed()
		return true
	else:
		return false

func create_generator(world_location: Vector2, layer) -> bool:
	var generator = GENERATOR.instance()
	if resource_manager.use_capital(generator.resource_handler.capital_cost):
		generator.add_to_group('equipment')
		generator.add_to_group('power_equipment')
		generator.name = 'generator'
		generator.position = world_location
		get_node('/root/Game/World/Layer_%s' % layer.number).add_child(generator)
		job_manager.create_job(generator.position, layer, 'equipment', generator.get_path())
		return true
	else:
		return false

func create_collector(world_location: Vector2, layer) -> bool:
	var collector = COLLECTOR.instance()
	if resource_manager.use_capital(collector.resource_handler.capital_cost):
		collector.add_to_group('equipment')
		collector.add_to_group('collector_equipment')
		collector.name = 'collector'
		collector.position = world_location
		get_node('/root/Game/World/Layer_%s' % layer.number).add_child(collector)
		job_manager.create_job(collector.position, layer, 'equipment', collector.get_path())
		return true
	else:
		return false

func create_distributor(world_location: Vector2, layer) -> bool:
	var distributor = DISTRIBUTOR.instance()
	if resource_manager.use_capital(distributor.resource_handler.capital_cost):
		distributor.add_to_group('equipment')
		distributor.add_to_group('distributor_equipment')
		distributor.name = 'distributor'
		distributor.position = world_location
		get_node('/root/Game/World/Layer_%s' % layer.number).add_child(distributor)
		job_manager.create_job(distributor.position, layer, 'equipment', distributor.get_path())
		return true
	else:
		return false

func create_matter_reactor(world_location: Vector2, layer) -> bool:
	var matter_reactor = MATTER_REACTOR.instance()
	if resource_manager.use_capital(matter_reactor.resource_handler.capital_cost):
		matter_reactor.add_to_group('equipment')
		matter_reactor.add_to_group('power_equipment')
		matter_reactor.name = 'matter_reactor'
		matter_reactor.position = world_location
		get_node('/root/Game/World/Layer_%s' % layer.number).add_child(matter_reactor)
		job_manager.create_job(matter_reactor.position, layer, 'equipment', matter_reactor.get_path())
		return true
	else:
		return false

func create_pump(world_location: Vector2, layer) -> bool:
	var pump = PUMP.instance()
	if resource_manager.use_capital(pump.resource_handler.capital_cost):
		pump.add_to_group('equipment')
		pump.add_to_group('coolant_equipment')
		pump.name = 'pump'
		pump.position = world_location
		get_node('/root/Game/World/Layer_%s' % layer.number).add_child(pump)
		job_manager.create_job(pump.position, layer, 'equipment', pump.get_path())
		return true
	else:
		return false

func create_scanner(world_location: Vector2, layer) -> bool:
	var scanner = SCANNER.instance()
	if resource_manager.use_capital(scanner.resource_handler.capital_cost):
		scanner.add_to_group('equipment')
		scanner.add_to_group('power_equipment')
		scanner.name = 'scanner'
		scanner.position = world_location
		get_node('/root/Game/World/Layer_%s' % layer.number).add_child(scanner)
		job_manager.create_job(scanner.position, layer, 'equipment', scanner.get_path())
		return true
	else:
		return false


# Need code for linking the two elevators together
func create_elevator(world_location: Vector2, layer) -> bool:
	var build_elevator_down = build_equipment(ELEVATOR_DOWN.instance(), 'elevator', world_location, layer.number, ['equipment', 'elevator_equipment', 'elevator_down'])
	var build_elevator_up = build_equipment(ELEVATOR_UP.instance(), 'elevator', world_location, layer.number + 1, ['equipment', 'elevator_equipment', 'elevator_up'], false)
	if build_elevator_down and build_elevator_up:
		return true
	else:
		return false


func build_equipment(equipment_instance: Equipment, type: String, world_location: Vector2, layer_number, group_list: Array, create_job := true) -> bool:
	if resource_manager.use_capital(equipment_instance.resource_handler.capital_cost):
		var layer = get_node('/root/Game/World/Layer_%s' % layer_number)
		for group in group_list:
			equipment_instance.add_to_group(group)
		equipment_instance.name = type
		equipment_instance.position = world_location
		layer.add_child(equipment_instance)
		if create_job:
			job_manager.create_job(equipment_instance.position, layer, 'equipment', equipment_instance.get_path())
		return true
	else:
		return false


func _on_Timer_timeout():
	resource_handler.reset()
	for equipment in get_tree().get_nodes_in_group('equipment'):
		if equipment.entity.on:
			resource_handler.add_to_power_and_coolant_pool(
				'equipment',
				equipment.resource_handler.power_usage,
				equipment.resource_handler.power_production * research_manager.research_affect_list['generator_power_multiplier'],
				equipment.resource_handler.coolant_usage,
				equipment.resource_handler.coolant_production * research_manager.research_affect_list['pump_coolant_multiplier']
				)
			if resource_manager.use_material(equipment.resource_handler.material_usage * research_manager.research_affect_list['matter_reactor_processing_multiplier']):
				resource_manager.gain_capital(equipment.resource_handler.capital_production * research_manager.research_affect_list['matter_reactor_processing_multiplier'])
	resource_manager.resource_handler.merge(resource_handler)
