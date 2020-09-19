extends Node2D


class_name EquipmentPlacement


onready var world: GameWorld = get_node('/root/Game/World')
onready var inner_rect = $InnerNinePatchRect
onready var outer_rect = $OuterNinePatchRect


var state_active = false
var elevator_placement = false
var valid_placement = false
var active_layer: WorldLayer
var world_layers = ProjectSettings.get_setting('game/config/world_layers')


func _ready():
	hide()

func show(elevator_placement := false):
	inner_rect.show()
	outer_rect.show()
#	print('open')
	self.set_process(true)
	self.state_active = true
	self.elevator_placement = elevator_placement
	self.valid_placement = false

func hide():
	inner_rect.hide()
	outer_rect.hide()
#	print('close')
	self.valid_placement = false
	self.elevator_placement = false
	self.state_active = false
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

func placement_area_valid(layer_number: int, tile_location: Vector2) -> bool:
	var layer = world.get_node('Layer_%s' % layer_number)
	var valid = true
	for pos_x in range(-1, 2):
		for pos_y in range(-1, 2):
			if not layer.tile_manager.tile_is_empty(Vector2(tile_location.x + pos_x, tile_location.y + pos_y)):
				valid = false
			if self.elevator_placement:
				if layer_number + 1 > world_layers:
					var next_layer = world.get_node('Layer_%s' % (layer_number + 1))
					if not next_layer.tile_manager.tile_is_elevator_safe(Vector2(tile_location.x + pos_x, tile_location.y + pos_y)):
						valid = false
				else:
					valid = false
	if valid:
		return true
	else:
		return false


func _process(delta):
	self.active_layer = world.get_node('Layer_%s' % world.current_active_layer)
	var tile_location: Vector2 = active_layer.tile_manager.world_to_map(get_global_mouse_position())

	valid_placement = placement_area_valid(world.current_active_layer, tile_location)

	if valid_placement:
		inner_rect.modulate = Color(0, 1.5, 0)
		outer_rect.modulate = Color(0, 0.5, 0)
	else:
		inner_rect.modulate = Color(1.5, 0, 0)
		outer_rect.modulate = Color(0.5, 0, 0)


	self.position = active_layer.tile_manager.world_to_map(get_global_mouse_position()) * active_layer.tile_size
