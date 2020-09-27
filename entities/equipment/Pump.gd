extends Equipment


class_name Pump


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
	self.add_to_group('coolant_equipment')
	self.name = 'pump'


func _init():
	self.type = 'pump'
	self.verbose_name = 'Pump'
	self.verbose_description = 'Consumes power to create coolant'
	resource_handler.power_usage = 10
	resource_handler.coolant_production = 460
	resource_handler.capital_cost = 4000
