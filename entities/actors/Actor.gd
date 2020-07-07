extends KinematicBody2D

class_name Actor

onready var entity = $Entity

onready var resource_handler: ResourceHandler = ResourceHandler.new()

var state: State
var state_manager: StateManager

var path = PoolVector2Array() setget set_path

func _process(delta):

	if state.new_state == 'idle':
		change_state('idle')

	if state.new_state == 'moving':
		change_state('moving')

	$Sprite.look_at(state.looking_point)

func _ready():
	state_manager = StateManager.new()
	change_state("idle")
	print('Actor Ready')

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
