extends Equipment


class_name Scanner


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
	self.name = 'scanner'


func _init():
	self.type = 'scanner'
	self.verbose_name = 'Scanner'
	self.verbose_description = 'Scans the layer (Not Implemented)'
	resource_handler.power_usage = 30
	resource_handler.coolant_usage = 30
	resource_handler.capital_cost = 6000
