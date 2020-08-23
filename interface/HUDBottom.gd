extends CanvasLayer

class_name HUDBottom

signal drone_menu_button_pressed
signal equipment_menu_button_pressed
signal research_menu_button_pressed
signal tutorial_menu_button_pressed

func _on_DroneMenuButton_pressed():
	emit_signal("drone_menu_button_pressed")

func _on_EquipmentMenuButton_pressed():
	emit_signal("equipment_menu_button_pressed")

func _on_TutorialMenuButton_pressed():
	emit_signal("tutorial_menu_button_pressed")

func _on_ResearchMenuButton_pressed():
	emit_signal("research_menu_button_pressed")
