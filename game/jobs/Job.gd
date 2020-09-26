extends Node


class_name Job


var accessibility: Dictionary = {
	'north': false,
	'east': false,
	'south': false,
	'west': false,
	'center': false,
}

var assigned_units: Dictionary = {
	'north': null,
	'east': null,
	'south': null,
	'west': null,
	'center': null,
}

var accessible_location: Vector2 = Vector2.ZERO

var tile_location: Vector2 = Vector2.ZERO
var world_location: Vector2 = Vector2.ZERO
var world_location_offset: Vector2 = Vector2.ZERO
var tile_size: int = ProjectSettings.get_setting('game/config/tile_size')
var tile_offset: int = tile_size / 2
var layer_number: int
var object_node_path: String
var object_node_id: int


var type_choices: Dictionary = {
		'digging': 'Digging Material',
		'material': 'Transport Material',
		'equipment': 'Building Equipment',
		'service': 'Service Equipmet or Drone',
	}


var type: String


func save_object():
	var save_dict = {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'accessibility': self.accessibility,
		'accessible_location': GlobalSaveManager.save_vector2(accessible_location),
		'tile_location': GlobalSaveManager.save_vector2(tile_location),
		'world_location': GlobalSaveManager.save_vector2(world_location),
		'world_location_offset': GlobalSaveManager.save_vector2(world_location_offset),
		'layer_number': layer_number,
		'type': type,
	}
	return save_dict

func load_object():
	pass

func _ready():
	self.add_to_group('jobs')
	self.add_to_group('Persist')
	world_location_offset = Vector2(world_location.x + tile_offset, world_location.y + tile_offset)
	get_parent().job_location_list[type][get_path()] = world_location_offset


func setup(world_location: Vector2, layer, type: String) -> void:
	self.add_to_group('%s_jobs' % type)
	self.set_type(type)
	self.tile_location = layer.dig_tile_map.world_to_map(world_location)
	self.layer_number = layer.number
	if self.type == 'digging':
		self.world_location = layer.dig_tile_map.map_to_world(self.tile_location)
		self.name = 'digging_l%s_x%s_y%s' % [layer.number, self.tile_location.x, self.tile_location.y]
	if self.type == 'material':
		self.world_location = world_location
		self.name = 'material_l%s_x%s_y%s' % [layer.number, self.world_location.x, self.world_location.y]
	if self.type == 'equipment':
		self.world_location = layer.dig_tile_map.map_to_world(self.tile_location)
		self.name = 'equipment_l%s_x%s_y%s' % [layer.number, self.tile_location.x, self.tile_location.y]
	if self.type == 'service':
		self.world_location = world_location
		self.name = 'service_l%s_x%s_y%s' % [layer.number, self.world_location.x, self.world_location.y]

func set_type(type: String):
	if type_choices.has(type):
		self.type = type

func get_work_tile_location(position: String) -> Vector2:
	if position == 'north':
		return Vector2(tile_location.x, tile_location.y - 1)
	if position == 'east':
		return Vector2(tile_location.x + 1, tile_location.y)
	if position == 'south':
		return Vector2(tile_location.x, tile_location.y + 1)
	if position == 'west':
		return Vector2(tile_location.x - 1, tile_location.y)
	if position == 'center':
		return tile_location
	else:
		return tile_location

func get_work_world_location(position: String) -> Vector2:
	if position == 'north':
		return Vector2(world_location.x + tile_offset,  world_location.y - 8)
	if position == 'east':
		return Vector2(world_location.x + tile_size + 8, world_location.y + tile_offset)
	if position == 'south':
		return Vector2(world_location.x + tile_offset, world_location.y + tile_size + 8)
	if position == 'west':
		return Vector2(world_location.x - 8, world_location.y + tile_offset)
	if position == 'center':
		return world_location
	else:
		return world_location

func _exit_tree():
		get_parent().job_location_list[self.type].erase(self.get_path())


