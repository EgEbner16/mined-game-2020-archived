extends Equipment


class_name ElevatorDown


var linked_elevator_up_node_path: String


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
	self.add_to_group('elevator_down_equipment')
	self.name = 'elevator_down'


func _init():
	self.type = 'elevator_down'
	self.verbose_name = 'Elevator Down'
	self.verbose_description = 'Allows drones to go between layers'
	resource_handler.power_usage = 50
	resource_handler.coolant_usage = 10
	resource_handler.capital_cost = 50000


func _physics_process(delta):
	if constructed < 100.0:
		var linked_elevator_up = get_node(self.linked_elevator_up_node_path)
		linked_elevator_up.constructed = constructed
	else:
		var linked_elevator_up = get_node(self.linked_elevator_up_node_path)
		linked_elevator_up.set_constructed()

