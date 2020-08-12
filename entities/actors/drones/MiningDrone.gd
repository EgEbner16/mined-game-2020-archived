extends Actor

class_name MiningDrone

onready var material_manager: MaterialManager = get_node('/root/Game/World/MaterialManager')

var digging = false
var digging_power = 100.00
var digging_timer = 0.0
var digging_speed = 4.0
var base_digging_speed = 4.0

func _init():
	self.resource_handler.capital_cost = 4000
	self.base_resource_handler.power_usage = 5
	self.base_resource_handler.coolant_usage = 2

func _ready():
	self.drone = true

func _process(delta):
	position = state.position

	if job_node_path:
		if has_node(job_node_path):
			if digging:
				if self.resource_manager.resource_handler.coolant_usage_percentage > 100:
					self.digging_speed = self.base_digging_speed * (self.resource_manager.resource_handler.coolant_usage_percentage / 100)
				else:
					self.digging_speed = self.base_digging_speed
				var job = get_node(job_node_path)
				digging_timer += delta
				if digging_timer > digging_speed:
					var job_tile_data = layer.tile_manager.get_tile_data(job.tile_location)
					self.base_resource_handler.coolant_usage = 2 + job_tile_data.digging_coolant_required
					layer.tile_manager.damage_tile(job.tile_location, digging_power)
					digging_timer = 0.0
					material_manager.create_material(self.position, layer, digging_power * job_tile_data.material_per_health)
					if layer.tile_manager.destroy_tile(job.tile_location):
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
	digging_speed = base_digging_speed
	digging = false
	working = false
	self.base_resource_handler.coolant_usage = 2
	change_state('idle')
