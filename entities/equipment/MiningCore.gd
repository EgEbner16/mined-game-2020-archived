extends "res://entities/equipment/Equipment.gd"


class_name MiningCore


func save_object():
	var save_dict = {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'position' : GlobalSaveManager.save_vector2(self.position),
		'constructed': self.constructed,
		'layer_number': self.layer_number,
	}
	return save_dict


func _ready():
	self.add_to_group('core_equipment')
	self.add_to_group('distributor_equipment')
	self.add_to_group('collector_equipment')
	self.name = 'mining_core'


func _init():
	self.type = 'mining_core'
	self.verbose_name = 'Mining Core'
	self.verbose_description = 'Center of your mining operation'
	resource_handler.power_production = 600
	resource_handler.coolant_production = 400
	resource_handler.material_usage = 300
	resource_handler.capital_production = 100
	resource_handler.capital_cost = 0
