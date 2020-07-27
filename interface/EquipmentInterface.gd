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
	place_equipment()


func _on_BuyDistributorEquipment_pressed():
	place_equipment()


func _on_BuyGeneratorEquipment_pressed():
	equipment_name_selected = 'generator'
	place_equipment()


func _on_BuyMatterReactorEquipment_pressed():
	place_equipment()


func _on_BuyPumpEquipment_pressed():
	place_equipment()


func _on_BuyScannerEquipment_pressed():
	place_equipment()

func _input(event):
	if Input.is_action_just_released("action_primary") and interface_manager.interface_state == 'equipment' and equipment_placement.is_valid():
		equipment_manager.create_equipment(equipment_name_selected, equipment_placement.active_layer.number, equipment_placement.position)
