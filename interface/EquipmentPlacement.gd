extends Node2D

class_name EquipmentPlacement

onready var world: GameWorld = get_node('/root/Game/World')

var state_active = false
var valid_placement = false
var active_layer: Layer

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
	if active_layer.tile_manager.tile_is_empty(active_layer.tile_manager.world_to_map(get_global_mouse_position())):
		valid_placement = true
	else:
		valid_placement = false
	self.position = active_layer.tile_manager.world_to_map(get_global_mouse_position()) * active_layer.tile_size
