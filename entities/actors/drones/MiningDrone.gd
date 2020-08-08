extends Actor

class_name MiningDrone

onready var material_manager: MaterialManager = get_node('/root/Game/World/MaterialManager')

var digging = false
var digging_timer = 0.0
var digging_speed = 10.0

func _init():
	resource_handler.capital_cost = 1500
	base_resource_handler.power_usage = 5
	base_resource_handler.coolant_usage = 2

func _ready():
	self.drone = true

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
					material_manager.create_material(self.position, layer)
#					get_node('/root/Game/ResourceManager').gain_material(1000)
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
							digging = true
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
	digging_timer = 0.0
	digging = false
	working = false
	change_state('idle')
