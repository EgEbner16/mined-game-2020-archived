extends Node

class_name JobManager

const JOB = preload("res://game/jobs/Job.tscn")

var job_location_list: Dictionary

var job_search_delay: float = 0.05
var job_search_timer: float = 0.0
var job_success_limit: int = 10

func _ready():
	pass # Replace with function body.

func create_tile_job(world_location: Vector2, layer: Layer):
	var job: Job = JOB.instance()
	job.add_to_group('jobs')
	job.tile_location = layer.dig_tile_map.world_to_map(world_location)
	job.world_location = layer.dig_tile_map.map_to_world(job.tile_location)
	job.name = 'dig_l%s_x%s_y%s' % [layer.number, job.tile_location.x, job.tile_location.y]
	job.layer_number = layer.number
	add_child(job)
	job_location_list[job.get_path()] = job.world_location_offset
	print(job_location_list[job.get_path()])

func remove_tile_job(world_location: Vector2, layer: Layer):
	var tile_location = layer.dig_tile_map.world_to_map(world_location)
	get_node('dig_l%s_x%s_y%s' % [layer.number, tile_location.x, tile_location.y]).queue_free()

func create_equipment_job(equipment: Equipment):
	pass

func clean_up_jobs():
	pass

func get_closest_job_node_paths(world_location: Vector2) -> Dictionary:
	var job_distance_list: Dictionary
	for job in job_location_list:
		job_distance_list[world_location.distance_to(job_location_list[job])] = job
#		print(world_location.distance_to(job_location_list[job]))
	var distance_array: Array = job_distance_list.keys()
	distance_array.sort()
	var job_closest_list: Dictionary
	for distance in distance_array:
		job_closest_list[distance] = job_distance_list[distance]
#		print(job_distance_list[distance])
	return job_closest_list

func _process(delta):
	job_search_timer += delta
	var job_found: bool = true
	var job_success: int = 0
	if job_search_timer > job_search_delay:
		job_search_timer = 0.0
		for mining_drone in get_tree().get_nodes_in_group('mining_drones'):
			if not mining_drone.working:
				job_found = false
				var job_path_list = get_closest_job_node_paths(mining_drone.position)
				for job_path in job_path_list:
					var job = get_node(job_path_list[job_path])
					job.accessibility = get_node('/root/Game/World/Layer_%s' % job.layer_number).tile_manager.get_accessibility(job.tile_location)
					if job.accessibility['north'] or job.accessibility['east'] or job.accessibility['south'] or job.accessibility['west']:
						if job.accessibility['north'] and not job.assigned_units['north']:
							mining_drone.job_node_path = job.get_path()
							mining_drone.job_position = 'north'
							mining_drone.working = true
							job.assigned_units['north'] = mining_drone
							job_found = true
							job_success += 1
							break
						elif job.accessibility['east'] and not job.assigned_units['east']:
							mining_drone.job_node_path = job.get_path()
							mining_drone.job_position = 'east'
							mining_drone.working = true
							job.assigned_units['east'] = mining_drone
							job_found = true
							job_success += 1
							break
						elif job.accessibility['south'] and not job.assigned_units['south']:
							mining_drone.job_node_path = job.get_path()
							mining_drone.job_position = 'south'
							mining_drone.working = true
							job.assigned_units['south'] = mining_drone
							job_found = true
							job_success += 1
							break
						elif job.accessibility['west'] and not job.assigned_units['west']:
							mining_drone.job_node_path = job.get_path()
							mining_drone.job_position = 'west'
							mining_drone.working = true
							job.assigned_units['west'] = mining_drone
							job_found = true
							job_success += 1
							break
			if not job_found or job_success >= job_success_limit:
				break
