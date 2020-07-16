extends Interface

class_name EquipmentInterface

func _ready():
	pass

func _input(event):
	if event.is_action_released("display_equipment_interface"):
		self.change_state()
