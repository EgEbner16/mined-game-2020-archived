extends Node


class_name ResourceManager


var resource_handler: ResourceHandler = ResourceHandler.new()


func save_object():
	var object_dict = {
		'resource_handler': self.resource_handler.save_object()
	}
	var save_dict = {
		'filename': get_filename(),
		'parent': get_parent().get_path(),
		'object_dict': object_dict,
	}
	return save_dict


func load_object(object_dict):
	self.resource_handler.load_object(object_dict['resource_handler'])


func _ready():
	self.add_to_group('Persist_50')


func _init():
	resource_handler.capital = ProjectSettings.get_setting('game/config/starting_capital')


func use_capital(amount: float) -> bool:
	if amount <= resource_handler.capital + resource_handler.capital_usage:
		resource_handler.capital_usage += amount
		return true
	else:
		return false


func use_material(amount: float) -> bool:
	if amount <= resource_handler.material + resource_handler.material_usage:
		resource_handler.material_usage += amount
		return true
	else:
		return false


func gain_capital(amount: float) -> void:
	resource_handler.capital_usage -= amount


func gain_material(amount: float) -> void:
	resource_handler.material_usage -= amount


func _on_Timer_timeout():
	resource_handler.capital -= resource_handler.capital_usage
	resource_handler.capital_usage = 0.0
	resource_handler.material -= resource_handler.material_usage
	resource_handler.material_usage = 0.0
	resource_handler.calculate_power_and_coolant()

