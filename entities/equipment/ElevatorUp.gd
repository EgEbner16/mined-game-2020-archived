extends Equipment


class_name ElevatorUp


var linked_elevator_down_node_path: String


func save_object():
	var save_dict = {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'position' : GlobalSaveManager.save_vector2(self.position),
		'constructed': self.constructed,
		'layer_number': self.layer_number,
	}
	return save_dict


func load_object():
	pass


func _ready():
	self.add_to_group('elevator_up_equipment')
	self.name = 'elevator_up'


func _init():
	self.type = 'elevator_up'
	self.verbose_name = 'Elevator Up'
	self.verbose_description = 'Allows drones to go between layers'
	resource_handler.power_usage = 50
	resource_handler.coolant_usage = 10
	resource_handler.capital_cost = 50000
