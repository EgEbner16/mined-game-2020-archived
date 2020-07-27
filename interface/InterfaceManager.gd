extends Node

class_name InterfaceManager

onready var hud = $HUD
onready var drone_interface = $DroneInterface
onready var equipment_interface = $EquipmentInterface
onready var options_menu = $OptionsMenu
onready var equipment_placement = $EquipmentPlacement

var interface_state = 'game'
var states: Array

func _init():
	self.states = [
		'game',
		'drone',
		'equipment',
		'options',
	]

func _ready():
	set_state('game')

func _input(event):
	if event.is_action_released("display_drone_interface"):
		drone_interface.change_state()
		if drone_interface.state_active:
			set_state('drone')
			equipment_interface.close()
		else:
			set_state('game')
		equipment_placement.hide()

	if event.is_action_released("display_equipment_interface"):
		equipment_interface.change_state()
		if equipment_interface.state_active:
			set_state('equipment')
			drone_interface.close()
		else:
			set_state('game')
		equipment_placement.hide()

func set_state(state_name: String):
	if self.states.has(state_name):
#		print('state changed')
		interface_state = state_name

