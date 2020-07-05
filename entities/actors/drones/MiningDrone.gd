extends "res://entities/actors/Actor.gd"

class_name MiningDrone

var working = false
var digging = false
var digging_timer = 0.0
var digging_speed = 10.0
var job_node_path = null
var job_position = null

func _ready():
	power_usage = 5
	coolant_usage = 2

func _process(delta):
	position = state.position
	
	if job_node_path:		
		if has_node(job_node_path):
			if digging:
				var job = get_node(job_node_path)
				digging_timer += delta
				if digging_timer > digging_speed:
					var layer = get_parent()
					layer.tile_manager.set_tile_index(job.tile_location, 1)
					get_node('/root/Game/ResourceManager').gain_material(1000)
					clear_to_idle()
				
			elif working and state_manager.current_state == 'idle':
				if has_node(job_node_path):
					var job = get_node(job_node_path)
					var layer = get_parent()
					if job.layer_number == layer.number:
						print ('Job is on same layer')
						if layer.terrain_tile_map.world_to_map(position) == job.get_work_tile_location(job_position):
							print('Currently at Job')
							self.state.looking_point = job.world_location_offset
							digging = true
						else:
							print('Need to Move to Job')
							set_path(layer.get_navigation_path(position, job.get_work_world_location(job_position)))
					else:
						print('Job is on another layer')
		else:
			clear_to_idle()
			
func clear_to_idle() -> void:
	if has_node(job_node_path):
		var job = get_node(job_node_path)
		job.queue_free()		
	job_node_path = null
	job_position = null
	digging_timer = 0.0
	digging = false
	working = false
	change_state('idle')
