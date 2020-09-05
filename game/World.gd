extends Node2D

class_name GameWorld

const LAYER = preload("res://game/Layer.tscn")
const JOB = preload("res://game/jobs/Job.tscn")

onready var current_active_layer: int = 0
onready var job_manager: JobManager = $JobManager
onready var drone_manager: DroneManager = $DroneManager
onready var equipment_manager: EquipmentManager = $EquipmentManager
onready var interface_manager: InterfaceManager = get_node('/root/Game/InterfaceManager')

var world_size = ProjectSettings.get_setting('game/config/world_size')
var world_tile_size = ProjectSettings.get_setting('game/config/tile_size')
var world_layers = ProjectSettings.get_setting('game/config/world_layers')
var world_center = world_size / 2
var top_layer = 0
var bottom_layer = world_layers - 1

# Performed when added to scene
func _ready():
	for i in range(0, world_layers):
		var layer = LAYER.instance()
		layer.add_to_group('layers')
		layer.number = i
		layer.name = str('Layer_%s' % i)
		if i == 0:
			layer.visible = true
		else:
			layer.visible = false
		add_child(layer)
	equipment_manager.create_equipment('mining_core', 0, get_node('Layer_%s' % 0).tile_manager.map_to_world(Vector2(world_center.x - 1, world_center.y - 1)))
	drone_manager.create_drone('mining', 0)
	drone_manager.create_drone('service', 0)
	drone_manager.create_drone('construction', 0)
	drone_manager.create_drone('logistic', 0)
	# Connects the whistle to creating a new path


func _input(event):
	if event.is_action_released('previous_layer') and current_active_layer > 0:
		previous_layer()
	if event.is_action_released('next_layer') and current_active_layer < bottom_layer:
		next_layer()
	if event.is_action_released('go_to_layer_0'):
		switch_layer(0)
	if event.is_action_released('go_to_layer_1'):
		switch_layer(1)
	if event.is_action_released('go_to_layer_2'):
		switch_layer(2)
	if event.is_action_released('go_to_layer_3'):
		switch_layer(3)
	if event.is_action_released('go_to_layer_4'):
		switch_layer(4)
	if event.is_action_released('go_to_layer_5'):
		switch_layer(5)
	if event.is_action_released('go_to_layer_6'):
		switch_layer(6)
	if event.is_action_released('go_to_layer_7'):
		switch_layer(7)
	if event.is_action_released('go_to_layer_8'):
		switch_layer(8)
	if event.is_action_released('go_to_layer_9'):
		switch_layer(9)

func switch_layer(number: int):
	if number <= self.bottom_layer:
		print('Going from Layer %s to Layer %s' % [self.current_active_layer, number])
		var active_layer: WorldLayer = get_node('Layer_%s' % current_active_layer)
		var switch_layer: WorldLayer = get_node('Layer_%s' % number)
		if switch_layer.number > active_layer.number:
			active_layer.animation_player.play('fade_out_up')
			switch_layer.animation_player.play('fade_in_up')
		elif switch_layer.number < active_layer.number:
			active_layer.animation_player.play('fade_out_down')
			switch_layer.animation_player.play('fade_in_down')
		self.current_active_layer = switch_layer.number


func previous_layer():
	switch_layer(self.current_active_layer - 1)

func next_layer():
	switch_layer(self.current_active_layer + 1)

func _process(delta):
	var active_layer: WorldLayer = get_node('Layer_%s' % current_active_layer)

	if Input.is_action_pressed("action_primary") and interface_manager.interface_state == 'game' and mouse_check():
		if(active_layer.set_dig_tile(get_global_mouse_position())):
			job_manager.create_job(get_global_mouse_position(), active_layer, 'digging')

	if Input.is_action_pressed("action_cancel") and interface_manager.interface_state == 'game':
		if(active_layer.unset_dig_tile(get_global_mouse_position())):
			job_manager.remove_job(get_global_mouse_position(), active_layer, 'digging')

#stop mouse clicks over the bottom bar buttons
func mouse_check() -> bool:
	if get_viewport().get_mouse_position().x < 300 and get_viewport().get_mouse_position().y > 685:
		return false
	elif get_viewport().get_mouse_position().x > 1180 and get_viewport().get_mouse_position().y > 685:
		return false
	else:
		return true
