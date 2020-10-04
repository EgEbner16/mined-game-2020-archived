extends Equipment


class_name Collector


func save_object():
	var save_dict = {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'position' : GlobalSaveManager.save_vector2(self.position),
		'constructed': self.constructed,
		'layer_number': self.layer_number,
	}
	return save_dict


func _init():
	self.type = 'collector'
	self.verbose_name = 'Collector'
	self.verbose_description = 'Drop off point for logistic drones'
	resource_handler.power_usage = 15
	resource_handler.coolant_usage = 5
	resource_handler.capital_cost = 10000

