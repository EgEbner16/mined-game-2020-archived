extends Actor

class_name ServiceDrone


var moving_to_repair: bool = false
var repair_object


func _init():
	resource_handler.capital_cost = 5000
	base_resource_handler.power_usage = 5
	base_resource_handler.coolant_usage = 2

func _ready():
	self.drone = true
	self.base_speed = 150
	self.speed = 150

func _process(delta):
	position = state.position

	if job_node_path:
		if has_node(job_node_path):
			if moving_to_repair:
				if position.distance_to(repair_object.position) <= 10.0:
#					print('Service Drone at Repair Point %s' % self.name)
					var job = get_node(job_node_path)
					repair_object.repair()
					$ServiceParticles.restart()
					clear_to_idle()
				elif path.size() > 0 and state_manager.current_state == 'idle':
#					print('tacos')
					moving_to_repair = true
					set_path(layer.get_navigation_path(position, repair_object.position))

			elif working and state_manager.current_state == 'idle':
				if has_node(job_node_path):
					self.speed = self.base_speed + research_manager.research_affect_list['service_drone_movement_speed_increase']
					var job = get_node(job_node_path)
					if job.layer_number == self.layer.number:
						repair_object = get_node(job.object_node_path)
#						print ('Job is on same layer %s' % position.distance_to(job.get_work_world_location(job_position)))
						if position.distance_to(repair_object.position) <= 10.0:
#							print('Service Drone Arrived at Job')
							self.state.looking_point = repair_object.position
							if job.type == 'service':
								moving_to_repair = true
								set_path(layer.get_navigation_path(position, repair_object.position))
						else:
							set_path(layer.get_navigation_path(position, repair_object.position))
							moving_to_repair = true
#							print('%s Need to Move to Job %s' % [self.name, path])
					else:
						pass
#						print('Job is on another layer')
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
#	print('Service Idle')
	change_state('idle')
