extends Node2D

class_name Layer

var world_size = ProjectSettings.get_setting("game/config/world_size")
var world_center = world_size / 2
var base_size = ProjectSettings.get_setting("game/config/base_size")
var base_left_x = int(world_center.x - base_size.x / 2)
var base_top_y = int(world_center.y - base_size.y / 2)
var number: int = 0

onready var tile_manager: TileManager = $TileManager
onready var navigation_2d: Navigation2D = $Navigation2D
onready var terrain_tile_map: TileMap = $Navigation2D/TerrainTileMap
onready var shadow_tile_map: TileMap = $ShadowTileMap
onready var dig_tile_map: TileMap = $DigTileMap
onready var equipment_manager: EquipmentManager = get_node('/root/Game/World/EquipmentManager')
onready var drone_manager: DroneManager = get_node('/root/Game/World/DroneManager')


func _ready():
	tile_manager.create_random_layer(world_size)
	for x in range(world_size.x):
		for y in range(world_size.y):
			tile_manager.update_tile(Vector2(x, y))
	if number == 0:
		for x in range(base_left_x, base_left_x + base_size.x):
			for y in range(base_top_y, base_top_y + base_size.y):
				tile_manager.set_tile_index(Vector2(x, y), 0)
		tile_manager.set_tile_index(Vector2(world_center.x - 1, world_center.y - 1), 15)
		equipment_manager.create_equipment('mining_core', number, tile_manager.map_to_world(Vector2(world_center.x - 1, world_center.y - 1)))


func get_navigation_path(start: Vector2, end: Vector2):
	var path = navigation_2d.get_simple_path(start, end)
	return path

func set_dig_tile(world_location: Vector2) -> bool:
	var tile = dig_tile_map.world_to_map(world_location)
	if dig_tile_map.get_cellv(tile) == -1 and terrain_tile_map.get_cellv(tile) >= 4:
		dig_tile_map.set_cellv(tile, 0)
		return true
	else:
		return false

func unset_dig_tile(world_location: Vector2) -> bool:
	var tile = dig_tile_map.world_to_map(world_location)
	if dig_tile_map.get_cellv(tile) == 0:
		dig_tile_map.set_cellv(tile, -1)
		return true
	else:
		return false

