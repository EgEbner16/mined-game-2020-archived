extends Node2D

class_name WorldLayer


export var zoom: float = 1.0
var zoom_current: float = 1.0
var zoom_default: float = 1.0


var world_size = ProjectSettings.get_setting('game/config/world_size')
var world_center = world_size / 2
var base_size = ProjectSettings.get_setting('game/config/base_size')
var tile_size = ProjectSettings.get_setting('game/config/tile_size')
var base_left_x = int(world_center.x - base_size.x / 2)
var base_top_y = int(world_center.y - base_size.y / 2)
var number: int = 0
var number_max: int = 0


onready var tile_manager: TileManager = $TileManager
onready var navigation_2d: Navigation2D = $Navigation2D
onready var terrain_tile_map: TileMap = $Navigation2D/TerrainTileMap
onready var shadow_tile_map: TileMap = $ShadowTileMap
onready var dig_tile_map: TileMap = $DigTileMap
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var equipment_manager: EquipmentManager = get_node('/root/Game/World/EquipmentManager')
onready var drone_manager: DroneManager = get_node('/root/Game/World/DroneManager')
onready var camera: KinematicBody2D = get_node('/root/Game/Camera')


func save_object():
	var save_dict = {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'position' : GlobalSaveManager.save_vector2(self.position),
		'zoom': self.zoom,
		'zoom_current': self.zoom_current,
		'zoom_default': self.zoom_default,
		'number': self.number,
		'number_max': self.number_max,
	}
	return save_dict

func load_object():
	pass

func after_load_object():
	self.name = 'Layer_%s' % number
	tile_manager.free()

func _ready():
	self.add_to_group('Persist_10')
	var difficulty = float(number) / float(number_max)
	tile_manager.create_random_layer(world_size, difficulty)
	tile_manager.update_layer()
	if number == 0:
		for x in range(base_left_x, base_left_x + base_size.x):
			for y in range(base_top_y, base_top_y + base_size.y):
				tile_manager.set_tile_index(Vector2(x, y), 0)
		tile_manager.set_tile_index(Vector2(world_center.x - 1, world_center.y - 1), 15)
	var terrain_color = 1.0 - (0.5 * difficulty)
	terrain_tile_map.modulate = Color(1.0, terrain_color, terrain_color)


func _physics_process(delta):
	if zoom != zoom_current:
		var map_size: float = self.world_size.x * self.tile_size
		var zoom_location_x: float = ((map_size - map_size * self.zoom) / 2) * (camera.position.x / (map_size / 2))
		var zoom_location_y: float = ((map_size - map_size * self.zoom) / 2) * (camera.position.y / (map_size / 2))
		self.scale = Vector2(self.zoom, self.zoom)
		self.position = Vector2(zoom_location_x, zoom_location_y)
		self.zoom_current = zoom


func get_navigation_path(start: Vector2, end: Vector2):
	var path = navigation_2d.get_simple_path(start, end)
	return path

func move_node_to_layer(node_path, layer):
	var node = get_node(node_path)
	self.remove_child(node)
	layer.add_child(node)
	node.layer = node.get_parent()

func set_dig_tile(world_location: Vector2) -> bool:
	var tile = dig_tile_map.world_to_map(world_location)
	if dig_tile_map.get_cellv(tile) == -1 and terrain_tile_map.get_cellv(tile) >= 4 and terrain_tile_map.get_cellv(tile) < 15 :
		dig_tile_map.set_cellv(tile, 0)
		dig_tile_map.update_bitmask_area(tile)
		tile_manager.change_map_key()
		return true
	else:
		return false


func unset_dig_tile(world_location: Vector2) -> bool:
	var tile = dig_tile_map.world_to_map(world_location)
	if dig_tile_map.get_cellv(tile) == 0:
		dig_tile_map.set_cellv(tile, -1)
		dig_tile_map.update_bitmask_area(tile)
		tile_manager.change_map_key()
		return true
	else:
		return false

