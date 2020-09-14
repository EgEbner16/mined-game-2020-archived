extends VBoxContainer


class_name EquipmentButton


onready var equipment_placement: EquipmentPlacement = get_node('/root/Game/InterfaceManager/EquipmentPlacement')
onready var equipment_interface = get_node('/root/Game/InterfaceManager/EquipmentInterface')


var equipment_type: String


func _input(event):
	if $Button.pressed:
		equipment_interface.equipment_name_selected = self.equipment_type
		if equipment_type == 'elevator_down':
			equipment_interface.place_elevator_equipment()
		else:
			equipment_interface.place_equipment()

