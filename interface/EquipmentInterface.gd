extends Interface


class_name EquipmentInterface


const EQUIPMENT_BUTTON = preload("res://interface/EquipmentButton.tscn")


const MINING_CORE = preload("res://entities/equipment/MiningCore.tscn")
const ELEVATOR_DOWN = preload("res://entities/equipment/ElevatorDown.tscn")
const ELEVATOR_UP = preload("res://entities/equipment/ElevatorUp.tscn")
const COLLECTOR = preload("res://entities/equipment/Collector.tscn")
const DISTRIBUTOR = preload("res://entities/equipment/Distributor.tscn")
const GENERATOR = preload("res://entities/equipment/Generator.tscn")
const MATTER_REACTOR = preload("res://entities/equipment/MatterReactor.tscn")
const PUMP = preload("res://entities/equipment/Pump.tscn")
const SCANNER = preload("res://entities/equipment/Scanner.tscn")


onready var equipment_placement: EquipmentPlacement = get_node('/root/Game/InterfaceManager/EquipmentPlacement')
onready var equipment_manager: EquipmentManager = get_node('/root/Game/World/EquipmentManager')
onready var interface_manager: InterfaceManager = get_parent()


var equipment_name_selected = 'none'


func _ready():
	create_equipment_button(GENERATOR.instance())
	create_equipment_button(PUMP.instance())
	create_equipment_button(MATTER_REACTOR.instance())
	create_equipment_button(COLLECTOR.instance())
	create_equipment_button(DISTRIBUTOR.instance())
	create_equipment_button(ELEVATOR_DOWN.instance())
	create_equipment_button(SCANNER.instance())


func create_equipment_button(equipment: Equipment):
	var equipment_button = EQUIPMENT_BUTTON.instance()
	equipment_button.equipment_type = equipment.type
	equipment_button.get_node("Button").text = equipment.verbose_name
	equipment_button.get_node("Description").text = "%s" % equipment.verbose_description
	equipment_button.get_node("Cost").text = "Cost: $%s" % equipment.resource_handler.capital_cost
	$ColorRect/HBoxContainer/VBoxContainer.add_child(equipment_button)


func place_equipment(elevator_placement := false):
	equipment_placement.show(elevator_placement)


func place_elevator_equipment():
	place_equipment(true)


func _input(event):
	if Input.is_action_just_released("action_primary") and interface_manager.interface_state == 'equipment' and equipment_placement.is_valid():
		if equipment_manager.create_equipment(equipment_name_selected, equipment_placement.active_layer.number, equipment_placement.position):
			if not Input.is_action_pressed("keep_equipment_placement"):
				equipment_placement.hide()
