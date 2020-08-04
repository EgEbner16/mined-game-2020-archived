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

# Performed when added to scene
func _ready():
	for i in range(0, world_layers):
		var layer = LAYER.instance()
		layer.add_to_group('layers')
		layer.number = i
		layer.name = str('Layer_%s' % i)
		add_child(layer)
	equipment_manager.create_equipment('mining_core', 0, get_node('Layer_%s' % 0).tile_manager.map_to_world(Vector2(world_center.x - 1, world_center.y - 1)))
	# Connects the whistle to creating a new path

func _process(delta):
	var active_layer: WorldLayer = get_node('Layer_%s' % current_active_layer)

	if Input.is_action_pressed("action_primary") and interface_manager.interface_state == 'game':
		if(active_layer.set_dig_tile(get_global_mouse_position())):
			job_manager.create_job(get_global_mouse_position(), active_layer, 'digging')

	if Input.is_action_pressed("action_cancel") and interface_manager.interface_state == 'game':
		if(active_layer.unset_dig_tile(get_global_mouse_position())):
			job_manager.remove_job(get_global_mouse_position(), active_layer, 'digging')
