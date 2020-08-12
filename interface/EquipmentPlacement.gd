extends Node2D

class_name EquipmentPlacement

onready var world: GameWorld = get_node('/root/Game/World')

var state_active = false
var valid_placement = false
var active_layer: WorldLayer

func _ready():
	hide()

func show():
	$NinePatchRect.show()
#	print('open')
	self.set_process(true)
	state_active = true
	valid_placement = false

func hide():
	$NinePatchRect.hide()
#	print('close')
	valid_placement = false
	state_active = false
	self.set_process(false)

func change_state():
	if state_active:
		self.hide()
	else:
		self.show()

func is_valid() -> bool:
	if state_active and valid_placement:
		return true
	else:
		return false

func _process(delta):
	self.active_layer = world.get_node('Layer_%s' % world.current_active_layer)
	if valid_placement:
		$NinePatchRect.modulate = Color(0, 1, 0)
	else:
		$NinePatchRect.modulate = Color(1, 0, 0)
	var tile_location: Vector2 = active_layer.tile_manager.world_to_map(get_global_mouse_position())
	if not active_layer.tile_manager.tile_is_empty(tile_location):
		valid_placement = false
	elif not active_layer.tile_manager.tile_is_empty(Vector2(tile_location.x - 1, tile_location.y - 1)):
		valid_placement = false
	elif not active_layer.tile_manager.tile_is_empty(Vector2(tile_location.x, tile_location.y - 1)):
		valid_placement = false
	elif not active_layer.tile_manager.tile_is_empty(Vector2(tile_location.x + 1, tile_location.y - 1)):
		valid_placement = false
	elif not active_layer.tile_manager.tile_is_empty(Vector2(tile_location.x + 1, tile_location.y)):
		valid_placement = false
	elif not active_layer.tile_manager.tile_is_empty(Vector2(tile_location.x + 1, tile_location.y + 1)):
		valid_placement = false
	elif not active_layer.tile_manager.tile_is_empty(Vector2(tile_location.x, tile_location.y + 1)):
		valid_placement = false
	elif not active_layer.tile_manager.tile_is_empty(Vector2(tile_location.x - 1, tile_location.y + 1)):
		valid_placement = false
	elif not active_layer.tile_manager.tile_is_empty(Vector2(tile_location.x - 1, tile_location.y)):
		valid_placement = false
	else:
		valid_placement = true
	self.position = active_layer.tile_manager.world_to_map(get_global_mouse_position()) * active_layer.tile_size
