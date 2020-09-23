extends Node

class_name InterfaceManager

onready var hud = $HUD
onready var hud_bottom = $HUDBottom
onready var drone_interface = $DroneInterface
onready var equipment_interface = $EquipmentInterface
onready var research_interface = $ResearchInterface
onready var tutorial_interface = $TutorialInterface
onready var options_menu = $OptionsMenu
onready var equipment_placement = $EquipmentPlacement

var interface_state = 'game'
var states: Array

func _init():
	self.states = [
		'game',
		'drone',
		'equipment',
		'research',
		'options',
		'tutorial',
	]

func _ready():
	hud_bottom.connect("drone_menu_button_pressed",self,"handle_drone_menu_button_pressed")
	hud_bottom.connect("equipment_menu_button_pressed",self,"handle_equipment_menu_button_pressed")
	hud_bottom.connect("research_menu_button_pressed",self,"handle_research_menu_button_pressed")
	hud_bottom.connect("tutorial_menu_button_pressed",self,"handle_tutorial_menu_button_pressed")
	set_state('game')

func handle_drone_menu_button_pressed():
	toggle_drone_interface()

func handle_equipment_menu_button_pressed():
	toggle_equipment_interface()

func handle_research_menu_button_pressed():
	toggle_research_interface()

func handle_tutorial_menu_button_pressed():
	toggle_tutorial_interface()


func _input(event):
	if event.is_action_released("display_drone_interface"):
		toggle_drone_interface()

	if event.is_action_released("display_equipment_interface"):
		toggle_equipment_interface()

	if event.is_action_released("display_research_interface"):
		toggle_research_interface()

	if event.is_action_released("display_tutorial_interface"):
		toggle_tutorial_interface()

	if self.interface_state != 'game':
		if event.is_action_released("action_primary"):
			if interface_state == 'research':
				if get_viewport().get_mouse_position().y > 520 and get_viewport().get_mouse_position().y < 680:
					close_interface()
			else:
				if get_viewport().get_mouse_position().x > 300 and get_viewport().get_mouse_position().y > 100:
					if get_viewport().get_mouse_position().x < 980 and get_viewport().get_mouse_position().y < 620:
						if not equipment_placement.state_active:
							close_interface()


func set_state(state_name: String):
	if self.states.has(state_name):
#		print('state changed')
		self.interface_state = state_name


func toggle_drone_interface():
		drone_interface.change_state()
		if drone_interface.state_active:
			set_state('drone')
			equipment_interface.close()
			research_interface.close()
			tutorial_interface.close()
		else:
			set_state('game')
		equipment_placement.hide()


func toggle_equipment_interface():
		equipment_interface.change_state()
		if equipment_interface.state_active:
			set_state('equipment')
			drone_interface.close()
			research_interface.close()
			tutorial_interface.close()
		else:
			set_state('game')
		equipment_placement.hide()


func toggle_research_interface():
		research_interface.change_state()
		if research_interface.state_active:
			set_state('research')
			equipment_interface.close()
			drone_interface.close()
			tutorial_interface.close()
		else:
			set_state('game')
		equipment_placement.hide()


func toggle_tutorial_interface():
		tutorial_interface.change_state()
		if tutorial_interface.state_active:
			set_state('tutorial')
			drone_interface.close()
			equipment_interface.close()
			research_interface.close()
		else:
			set_state('game')
		equipment_placement.hide()


func close_interface():
		set_state('game')
		drone_interface.close()
		equipment_interface.close()
		research_interface.close()
		tutorial_interface.close()
		equipment_placement.hide()
