extends Actor


class_name ServiceDrone


var moving_to_repair: bool = false
var repair_object


func save_object():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"position" : GlobalSaveManager.save_vector2(self.position),
	}
	return save_dict


func _init():
	resource_handler.capital_cost = 5000
	base_resource_handler.power_usage = 5
	base_resource_handler.coolant_usage = 2


func _ready():
	self.add_to_group('drones')
	self.add_to_group('service_drones')
	self.drone = true
	self.base_speed = 150
	self.speed = 150


func _process(delta):
	if job_node_path:
		if has_node(job_node_path):
			if moving_to_repair:
#				print('Distance to Repair: %s' % self.position.distance_to(repair_object.position))
				if self.position.distance_to(repair_object.position) <= 16.0 and self.layer.number == repair_object.layer.number:
#					print('Service Drone at Repair Point %s' % self.name)
					repair_object.repair()
					$ServiceParticles.restart()
					clear_to_idle()

			if working and state_manager.current_state == 'idle':
				if has_node(job_node_path):
					self.speed = self.base_speed + research_manager.research_affect_list['service_drone_movement_speed_increase']
					var job = get_node(job_node_path)
					repair_object = instance_from_id(job.object_node_id)
					if job.type == 'service':
						self.state.looking_point = repair_object.position
						go_to_destination(repair_object.position, repair_object.layer.number)
						moving_to_repair = true
		else:
			clear_to_idle()


func clear_to_idle() -> void:
	if has_node(job_node_path):
		var job = get_node(job_node_path)
		job.queue_free()
	job_node_path = null
	job_position = null
	moving_to_repair = false
	working = false
	change_state('idle')
