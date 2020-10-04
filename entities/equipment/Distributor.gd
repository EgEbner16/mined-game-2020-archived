extends Equipment


class_name Distributor


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
	self.type = 'distributor'
	self.verbose_name = 'Distributor'
	self.verbose_description = 'Distributes power to drones remotely'
	resource_handler.power_usage = 5
	resource_handler.coolant_usage = 20
	resource_handler.capital_cost = 5000
