extends Interface

class_name EquipmentInterface

onready var equipment_placement: EquipmentPlacement = get_node('/root/Game/InterfaceManager/EquipmentPlacement')
onready var equipment_manager: EquipmentManager = get_node('/root/Game/World/EquipmentManager')
onready var interface_manager: InterfaceManager = get_parent()

var equipment_name_selected = 'none'

func _ready():
	pass

func place_equipment():
	equipment_placement.show()

func _on_BuyCollectorEquipment_pressed():
	equipment_name_selected = 'collector'
	place_equipment()


func _on_BuyDistributorEquipment_pressed():
	equipment_name_selected = 'distributor'
	place_equipment()


func _on_BuyGeneratorEquipment_pressed():
	equipment_name_selected = 'generator'
	place_equipment()


func _on_BuyMatterReactorEquipment_pressed():
	equipment_name_selected = 'matter_reactor'
	place_equipment()


func _on_BuyPumpEquipment_pressed():
	equipment_name_selected = 'pump'
	place_equipment()


func _on_BuyScannerEquipment_pressed():
	equipment_name_selected = 'scanner'
	place_equipment()

func _input(event):
	if Input.is_action_just_released("action_primary") and interface_manager.interface_state == 'equipment' and equipment_placement.is_valid():
		if equipment_manager.create_equipment(equipment_name_selected, equipment_placement.active_layer.number, equipment_placement.position):
			if not Input.is_action_pressed("keep_equipment_placement"):
				equipment_placement.hide()
