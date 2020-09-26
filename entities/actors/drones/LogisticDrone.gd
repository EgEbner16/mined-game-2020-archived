extends Actor

class_name LogisticDrone


var carrying_load = false
var base_storage_capacity = 3
var storage_capacity = 3
var storage = 0
var drop_off_location: Vector2
var drop_off_layer_number: int

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"position" : GlobalSaveManager.save_vector2(self.position),
	}
	return save_dict

func _init():
	resource_handler.capital_cost = 2000
	base_resource_handler.power_usage = 5
	base_resource_handler.coolant_usage = 2


func _ready():
	self.add_to_group('drones')
	self.add_to_group('logistic_drones')
	self.drone = true
	self.base_speed = 125
	self.speed = 125


func _process(delta):
	if job_node_path:
		if has_node(job_node_path):
			if carrying_load:
				if position.distance_to(drop_off_location) <= 24.0 and self.layer.number == drop_off_layer_number:
#					print('Logistic Drone at Drop off Point %s' % self.name)
					var job = get_node(job_node_path)
					get_node('/root/Game/ResourceManager').gain_material(self.resource_handler.material * research_manager.research_affect_list['collector_efficiency_multiplier'])
					resource_handler.material = 0
					storage = 0
					clear_to_idle()
				elif state_manager.current_state == 'idle':
					var closest_collector = get_node(equipment_manager.get_closest_equipment(self.position, layer, 'collector', true, false))
					drop_off_location = Vector2(closest_collector.position.x + 16, closest_collector.position.y)
					drop_off_layer_number = closest_collector.layer.number
					go_to_destination(Vector2(closest_collector.position.x + 16, closest_collector.position.y), closest_collector.layer.number)
#					print('going home! %s' % closest_collector.layer.number)

			elif working and state_manager.current_state == 'idle':
				if has_node(job_node_path):
					storage_capacity = base_storage_capacity + research_manager.research_affect_list['logistic_drone_storage_capacity_increase']
					var job = get_node(job_node_path)
					if job.layer_number == self.layer.number:
#						print ('Job is on same layer %s' % position.distance_to(job.get_work_world_location(job_position)))
						if position.distance_to(job.get_work_world_location(job_position)) <= 16.0:
							#print('Logistic Drone Arrived at Job')
							self.state.looking_point = job.world_location_offset
							if job.type == 'material':
								var material = get_node(job.object_node_path)
								resource_handler.material += material.resource_handler.material
#								print('Material Job with %s!!!' % material.resource_handler.material)
								material.queue_free()
								storage += 1
								if storage >= storage_capacity:
#									var closest_collector = get_node(equipment_manager.get_closest_equipment(self.position, layer, 'collector', true, false))
	#								print(closest_collector.name)
#									go_to_destination(Vector2(closest_collector.position.x + 16, closest_collector.position.y), closest_collector.layer.number)
									carrying_load = true
								else:
									clear_to_idle()
						else:
							go_to_destination(job.get_work_world_location(job_position), job.layer_number)
					else:
						go_to_destination(job.get_work_world_location(job_position), job.layer_number)
		else:
			clear_to_idle()

func clear_to_idle() -> void:
	if has_node(job_node_path):
		var job = get_node(job_node_path)
		job.queue_free()
	job_node_path = null
	job_position = null
	carrying_load = false
	working = false
#	print('Logistic Idle')
	change_state('idle')
