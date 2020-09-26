extends Actor


class_name MiningDrone


onready var material_manager: MaterialManager = get_node('/root/Game/World/MaterialManager')


var digging = false
var digging_power = 100.00
var digging_timer = 0.0
var digging_speed = 2.0
var base_digging_speed = 2.0


func save_object():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"position" : GlobalSaveManager.save_vector2(self.position),
	}
	return save_dict


func _init():
	self.resource_handler.capital_cost = 4000
	self.base_resource_handler.power_usage = 5
	self.base_resource_handler.coolant_usage = 2


func _ready():
	self.add_to_group('drones')
	self.add_to_group('mining_drones')
	self.base_speed = 100
	self.speed = 100
	self.drone = true
	$DiggingParticles.set_emitting(false)


func _process(delta):
	if job_node_path:
		if has_node(job_node_path):
			if digging:
				if not $DiggingParticles.is_emitting():
					$AnimatedSprite.look_at(self.state.looking_point)
					$DiggingParticles.rotation_degrees = $AnimatedSprite.rotation_degrees
					$DiggingParticles.set_emitting(true)
				if self.resource_manager.resource_handler.coolant_usage_percentage > 100:
					self.digging_speed = ((self.base_digging_speed * (self.resource_manager.resource_handler.coolant_usage_percentage / 100)) - research_manager.research_affect_list['mining_drone_dig_speed_reduction']) * (2.0 - self.entity.get_durability_percentage())
				else:
					self.digging_speed = (self.base_digging_speed - research_manager.research_affect_list['mining_drone_dig_speed_reduction'])  * (2.0 - self.entity.get_durability_percentage())
				var job = get_node(job_node_path)
				digging_timer += delta
#				print($AnimatedSprite.rotation_degrees)
				if digging_timer >= digging_speed:
					$DiggingSound.play()
					$DiggingBurstParticles.rotation_degrees = $AnimatedSprite.rotation_degrees
					$DiggingBurstParticles.restart()
					var job_tile_data = layer.tile_manager.get_tile_data(job.tile_location)
					self.base_resource_handler.coolant_usage = 2 + job_tile_data.digging_coolant_required
					layer.tile_manager.damage_tile(job.tile_location, digging_power)
					digging_timer = 0.0
					material_manager.create_material(self.position, layer, digging_power * job_tile_data.material_per_health)
					if layer.tile_manager.destroy_tile(job.tile_location):
						$DiggingParticles.set_emitting(false)
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
	digging_timer = 0.0
	digging_speed = base_digging_speed
	$DiggingParticles.set_emitting(false)
	digging = false
	working = false
	self.base_resource_handler.coolant_usage = 2
	change_state('idle')
