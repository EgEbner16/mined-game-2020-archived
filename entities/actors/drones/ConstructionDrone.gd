extends Actor

class_name ConstructionDrone

var constructing = false
var constructing_power = 1.0

func _init():
	resource_handler.capital_cost = 5000
	resource_handler.power_usage = 5
	resource_handler.coolant_usage = 2

func _ready():
	pass

func _process(delta):
	position = state.position

	if job_node_path:
		if has_node(job_node_path):
			if constructing:
				var job = get_node(job_node_path)
				var equipment = get_node(job.object_node_path)
				if equipment.constructed < 100.0:
					var layer = get_parent()
					equipment.constructed += (constructing_power * delta)
				else:
					equipment.constructed = 100.0
					print('Done!!!')
					clear_to_idle()

			elif working and state_manager.current_state == 'idle':
				if has_node(job_node_path):
					var job = get_node(job_node_path)
					var layer = get_parent()
					if job.layer_number == layer.number:
#						print ('Job is on same layer')
						if layer.terrain_tile_map.world_to_map(position) == job.get_work_tile_location(job_position):
#							print('Mining Drone Arrived at Job')
							self.state.looking_point = job.world_location_offset
							constructing = true
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
	constructing = false
	working = false
	change_state('idle')
