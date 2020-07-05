extends Node2D

const POPUP = preload("res://interface/Popup.tscn")
const LAYER = preload("res://game/Layer.tscn")
const JOB = preload("res://game/jobs/Job.tscn")

onready var current_active_layer: int = 0
onready var job_manager: JobManager = $JobManager
onready var drone_manager: DroneManager = $DroneManager
onready var equipment_manager: EquipmentManager = $EquipmentManager

var world_size = ProjectSettings.get_setting('game/config/world_size')
var world_tile_size = ProjectSettings.get_setting('game/config/tile_size')
var world_layers = ProjectSettings.get_setting('game/config/world_layers')

# Performed when added to scene
func _ready():
	for i in range(0, world_layers):
		var layer = LAYER.instance()
		layer.add_to_group('layers')
		layer.number = i
		layer.name = str('Layer_%s' % i)
		add_child(layer)
	# Connects the whistle to creating a new path

func _process(delta):
	var active_layer: Layer = get_node('Layer_%s' % current_active_layer)

	if Input.is_action_pressed("debug_mine_tile"):
		active_layer.tile_manager.set_tile_index(active_layer.terrain_tile_map.world_to_map(get_global_mouse_position()), 1)

	if Input.is_action_just_released("action_command"):
		drone_manager.create_drone('mining', current_active_layer, get_global_mouse_position())
		
	if Input.is_action_pressed("action_primary"):
		if(active_layer.set_dig_tile(get_global_mouse_position())):
			job_manager.create_tile_job(get_global_mouse_position(), active_layer)
	
	if Input.is_action_pressed("action_cancel"):
		if(active_layer.unset_dig_tile(get_global_mouse_position())):
			job_manager.remove_tile_job(get_global_mouse_position(), active_layer)
