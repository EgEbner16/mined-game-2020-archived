extends Equipment


class_name MatterReactor


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
	self.type = 'matter_reactor'
	self.verbose_name = 'Matter Reactor'
	self.verbose_description = 'Converts material into capital'
	resource_handler.power_usage = 50
	resource_handler.coolant_usage = 20
	resource_handler.material_usage = 1300
	resource_handler.capital_production = 400
	resource_handler.capital_cost = 10000
