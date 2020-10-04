extends Equipment


class_name Generator


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
	self.add_to_group('power_equipment')


func _init():
	self.type = 'generator'
	self.verbose_name = 'Generator'
	self.verbose_description = 'Consumes coolant to generate power'
	resource_handler.power_production = 280
	resource_handler.coolant_usage = 20
	resource_handler.capital_cost = 7500
