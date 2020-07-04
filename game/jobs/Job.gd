extends Node

class_name Job

var accessibility: Dictionary = {
	'north': false,
	'east': false,
	'south': false,
	'west': false,
}
var assigned_units: Dictionary = {
	'north': null,
	'east': null,
	'south': null,
	'west': null,
}

var accessible_location: Vector2 = Vector2.ZERO

var tile_location: Vector2 = Vector2.ZERO
var world_location: Vector2 = Vector2.ZERO
var world_location_offset: Vector2 = Vector2.ZERO
var tile_size: int = ProjectSettings.get_setting('game/config/tile_size')
var tile_offset: int = tile_size / 2
var layer_number: int

var type: Dictionary

func _ready():
	world_location_offset = Vector2(world_location.x + tile_offset, world_location.y + tile_offset)
	type = {
		'dig': 'Digging',
	}

func get_work_tile_location(position: String) -> Vector2:
	if position == 'north':
		return Vector2(tile_location.x, tile_location.y - 1)
	if position == 'east':
		return Vector2(tile_location.x + 1, tile_location.y)
	if position == 'south':
		return Vector2(tile_location.x, tile_location.y + 1)
	if position == 'west':
		return Vector2(tile_location.x - 1, tile_location.y)
	else:
		return Vector2(tile_location)

func get_work_world_location(position: String) -> Vector2:
	if position == 'north':
		return Vector2(world_location.x + tile_offset,  world_location.y - 8)
	if position == 'east':
		return Vector2(world_location.x + tile_size + 8, world_location.y + tile_offset)
	if position == 'south':
		return Vector2(world_location.x + tile_offset, world_location.y + tile_size + 8)
	if position == 'west':
		return Vector2(world_location.x - 8, world_location.y + tile_offset)
	else:
		return Vector2(world_location)

func _exit_tree():
	get_parent().job_location_list.erase(self.get_path())
