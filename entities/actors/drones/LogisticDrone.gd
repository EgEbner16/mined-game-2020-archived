extends Actor

class_name LogisticDrone

var carrying_load = false
var drop_off_location: Vector2

func _init():
	resource_handler.capital_cost = 500
	resource_handler.power_usage = 5
	resource_handler.coolant_usage = 2

func _ready():
	pass

func _process(delta):
	position = state.position

	if job_node_path:
		if has_node(job_node_path):
			if carrying_load:
				if position.distance_to(drop_off_location) <= 20.0:
					print('Logistic Drone at Drop off Point')
					var job = get_node(job_node_path)
					get_node('/root/Game/ResourceManager').gain_material(resource_handler.material)
					resource_handler.material = 0
					clear_to_idle()
				else:
					var layer = get_parent()

			elif working and state_manager.current_state == 'idle':
				if has_node(job_node_path):
					var job = get_node(job_node_path)
					var layer = get_parent()
					if job.layer_number == layer.number:
#						print ('Job is on same layer')
						if layer.terrain_tile_map.world_to_map(position) == job.get_work_tile_location(job_position):
							print('Logistic Drone Arrived at Job')
							self.state.looking_point = job.world_location_offset
							if job.type == 'material':
								var material = get_node(job.object_node_path)
								resource_handler.material = material.resource_handler.material
								print('Material Job with %s!!!' % material.resource_handler.material)
								material.queue_free()
								var mining_core = get_node('/root/Game/World/Layer_0/mining_core/')
								drop_off_location = mining_core.position
								set_path(layer.get_navigation_path(position, drop_off_location))
							carrying_load = true
						else:
#							print('Need to Move to Job')
							set_path(layer.get_navigation_path(position, job.get_work_world_location(job_position)))
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
	drop_off_location = Vector2.ZERO
	carrying_load = false
	working = false
	change_state('idle')
