extends Node

class_name TileManager

var index_information: Dictionary
var tile_map: Dictionary

var world_size: Vector2 = ProjectSettings.get_setting('game/config/world_size')

func _ready():
	index_information = {
		0: {'type': 'Ground', 'navigation': true},
		1: {'type': 'Mined Ground', 'navigation': true},
		2: {'type': 'Compacted Ground', 'navigation': true},
		3: {'type': 'Renforced Ground', 'navigation': true},
		4: {'type': 'Mass', 'navigation': false},
		5: {'type': 'Solid Mass', 'navigation': false},
		6: {'type': 'Low Value Tier 1', 'navigation': false},
		7: {'type': 'High Value Tier 1', 'navigation': false},
		8: {'type': 'Low Value Tier 2', 'navigation': false},
		9: {'type': 'High Value Tier 2', 'navigation': false},
		10: {'type': 'Low Value Tier 3', 'navigation': false},
		11: {'type': 'High Value Tier 3', 'navigation': false},
		12: {'type': 'Low Value Tier 4', 'navigation': false},
		13: {'type': 'High Value Tier 4', 'navigation': false},
		14: {'type': 'Water', 'navigation': false},
		15: {'type': 'Blank', 'navigation': false},
	}

func create_tile(tile_location: Vector2, index) -> void:
	tile_map['x%s_y%s' % [tile_location.x, tile_location.y]] = Tile.new(tile_location, index)
	
func create_random_tile(tile_location: Vector2) -> void:
	create_tile(tile_location, randi() % 10 + 4)
	
func create_random_layer(world_size: Vector2) -> void:
	for x in range(world_size.x):
		for y in range(world_size.y):
			create_random_tile(Vector2(x, y))
			get_parent().dig_tile_map.set_cellv(Vector2(x, y), -1)

func set_tile_index(tile_location: Vector2, index) -> void:
	tile_map['x%s_y%s' % [tile_location.x, tile_location.y]].index = index
	update_tile(tile_location)
	
func get_tile_index(tile_location: Vector2) -> int:
	return tile_map['x%s_y%s' % [tile_location.x, tile_location.y]].index

func update_tile(tile_location: Vector2) -> void:
	get_parent().terrain_tile_map.set_cellv(tile_location, tile_map['x%s_y%s' % [tile_location.x, tile_location.y]].index)
	get_parent().dig_tile_map.set_cellv(tile_location, -1)
	if index_information[tile_map['x%s_y%s' % [tile_location.x, tile_location.y]].index]['navigation']:
		get_parent().shadow_tile_map.set_cellv(tile_location, 0)
		get_parent().shadow_tile_map.update_bitmask_area(tile_location)

func world_to_map(world_location: Vector2) -> Vector2:
	return get_parent().terrain_tile_map.world_to_map(world_location)

func map_to_world(map_location: Vector2) -> Vector2:
	return get_parent().terrain_tile_map.map_to_world(map_location)

func get_accessibility(tile_location: Vector2) -> Dictionary:
	var accessibility: Dictionary = {
		'north': false,
		'east': false,
		'south': false,
		'west': false,
	}

	#North Check	
	if tile_location.y > 0:
		if index_information[tile_map['x%s_y%s' % [tile_location.x, tile_location.y - 1]].index]['navigation']:
			accessibility['north'] = true
	
	#East Check
	if tile_location.x < world_size.x:
		if index_information[tile_map['x%s_y%s' % [tile_location.x + 1, tile_location.y]].index]['navigation']:
			accessibility['east'] = true

	#South Check	
	if tile_location.y < world_size.y:
		if index_information[tile_map['x%s_y%s' % [tile_location.x, tile_location.y + 1]].index]['navigation']:
			accessibility['south'] = true
	
	#West Check
	if tile_location.x > 0:
		if index_information[tile_map['x%s_y%s' % [tile_location.x - 1, tile_location.y]].index]['navigation']:
			accessibility['west'] = true

	return accessibility
