extends KinematicBody2D

class_name Actor

onready var entity = $Entity

var working = false

var job_node_path = null
var job_position = null

var resource_handler: ResourceHandler = ResourceHandler.new()
var base_resource_handler: ResourceHandler = ResourceHandler.new()

var drone: bool = false
var drone_distance_to_distributor: float = 0.0

onready var layer = get_parent()
onready var equipment_manager: EquipmentManager = get_node('/root/Game/World/EquipmentManager')

var state: State
var state_manager: StateManager

var path = PoolVector2Array() setget set_path

func _process(delta):

	if state.new_state == 'idle':
		change_state('idle')

	if state.new_state == 'moving':
		change_state('moving')

	$AnimatedSprite.look_at(state.looking_point)

func _ready():
	state_manager = StateManager.new()
	change_state("idle")
#	print('Actor Ready')

func set_path(value):
	path = value
	if value.size() == 0:
		return
	change_state("moving")

func change_state(new_state_name):
	if state:
		state.queue_free()
	state = state_manager.get_state(new_state_name).new()
	state.setup(funcref(self, "change_state"), self)
	state.name = "current_state"
	add_child(state)

func change_layer(layer_number: int):
	pass

func _on_Timer_timeout():
	if drone:
		self.drone_distance_to_distributor = equipment_manager.get_distance_to_closest_equipment(self.position, layer, 'distributor')
#		print('Updating Distance to Distributor %s' % drone_distance_to_distributor)
		var multiplyer: float = 1.0
		var free_distance: float = 200.0
		if drone_distance_to_distributor > free_distance:
			multiplyer = 1.0 + ((drone_distance_to_distributor - free_distance) / free_distance)
		resource_handler.power_usage = base_resource_handler.power_usage * multiplyer
		resource_handler.coolant_usage = base_resource_handler.coolant_usage * multiplyer
#		print('Power Usage: %s' % resource_handler.power_usage)

