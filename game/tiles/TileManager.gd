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

func damage_tile(tile_location: Vector2, amount) -> void:
	tile_map['x%s_y%s' % [tile_location.x, tile_location.y]].remove_health(amount)

func destroy_tile(tile_location: Vector2) -> bool:
	if tile_map['x%s_y%s' % [tile_location.x, tile_location.y]].health <= 0:
		set_tile_index(tile_location, 1)
		return true
	else:
		return false

func create_tile(tile_location: Vector2, index) -> void:
	tile_map['x%s_y%s' % [tile_location.x, tile_location.y]] = Tile.new(tile_location, index)

func create_random_tile(tile_location: Vector2) -> void:
	create_tile(tile_location, randi() % 10 + 4)

func create_random_mass_tile(tile_location: Vector2) -> void:
	if randi() % 4 == 1:
		create_tile(tile_location, 5)
	else:
		create_tile(tile_location, 4)

func create_vein(tile_location: Vector2, tier: int, size: int) -> void:
	var low_material: int
	var high_material: int

	if tier == 1:
		low_material = 6
		high_material = 7
	if tier == 2:
		low_material = 8
		high_material = 9
	if tier == 3:
		low_material = 10
		high_material = 11
	if tier == 4:
		low_material = 12
		high_material = 13

	var vein_min_x = tile_location.x - int(size / 2)
	if vein_min_x < 0:
		vein_min_x = 0
	var vein_min_y = tile_location.y - int(size / 2)
	if vein_min_y < 0:
		vein_min_y = 0
	var vein_max_x = tile_location.x + int(size / 2)
	if vein_max_x > self.world_size.x:
		vein_max_x = self.world_size.x
	var vein_max_y = tile_location.y + int(size / 2)
	if vein_max_y > self.world_size.y:
		vein_max_y = self.world_size.y

	for x in range(vein_min_x, vein_max_x):
		for y in range(vein_min_y, vein_max_y):
			if randi() % 4 == 1:
				create_tile(Vector2(x, y), high_material)
			elif randi() % 3 == 1:
				create_tile(Vector2(x, y), low_material)
			elif randi() % 2 == 1:
				create_tile(Vector2(x, y), 5)

func create_random_layer(world_size: Vector2) -> void:
	var world_center = world_size / 2
	var vein_avoid_size = 20
	var vein_avoid_min_x = int(world_center.x - vein_avoid_size)
	var vein_avoid_min_y = int(world_center.y - vein_avoid_size)
	var vein_avoid_max_x = int(world_center.x + vein_avoid_size)
	var vein_avoid_max_y = int(world_center.y + vein_avoid_size)
	for x in range(world_size.x):
		for y in range(world_size.y):
			create_random_mass_tile(Vector2(x, y))
			if x in range(vein_avoid_min_x, vein_avoid_max_x) and y in range(vein_avoid_min_y, vein_avoid_max_y):
				create_random_mass_tile(Vector2(x, y))
			else:
				if randi() % 2000 == 1:
					create_vein(Vector2(x, y), 4, randi() % 8 + 4)
				elif randi() % 1500 == 1:
					create_vein(Vector2(x, y), 3, randi() % 10 + 5)
				elif randi() % 1000 == 1:
					create_vein(Vector2(x, y), 2, randi() % 12 + 6)
				elif randi() % 500 == 1:
					create_vein(Vector2(x, y), 1, randi() % 15 + 10)

func set_tile_index(tile_location: Vector2, index) -> void:
	tile_map['x%s_y%s' % [tile_location.x, tile_location.y]].index = index
	update_tile(tile_location)

func set_tile_to_blank(tile_location: Vector2) -> void:
	tile_map['x%s_y%s' % [tile_location.x, tile_location.y]].index = 15
	update_tile(tile_location)

func get_tile_index(tile_location: Vector2) -> int:
	return tile_map['x%s_y%s' % [tile_location.x, tile_location.y]].index

func tile_is_empty(tile_location: Vector2) -> bool:
	if index_information[get_tile_index(tile_location)]['navigation']:
		return true
	else:
		return false

func update_tile(tile_location: Vector2) -> void:
	get_parent().terrain_tile_map.set_cellv(tile_location, tile_map['x%s_y%s' % [tile_location.x, tile_location.y]].index)
	get_parent().dig_tile_map.set_cellv(tile_location, -1)
	get_parent().dig_tile_map.update_bitmask_area(tile_location)
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
