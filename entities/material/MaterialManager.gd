extends Node

class_name MaterialManager

const MATERIAL = preload("res://entities/material/Material.tscn")

var tile_size = ProjectSettings.get_setting("game/config/tile_size")

onready var job_manager: JobManager = get_node('/root/Game/World/JobManager')

var random = RandomNumberGenerator.new()

func _ready():
	pass

func create_material(world_position: Vector2, layer, value: float) -> void:
	var material: GameMaterial = MATERIAL.instance()
	material.add_to_group('material')
	var position_x = world_position.x + self.random.randi_range(-4, 4)
	var position_y = world_position.y + self.random.randi_range(-4, 4)
	material.position = Vector2(position_x, position_y)
	material.resource_handler.material = value
	get_node('/root/Game/World/Layer_%s' % layer.number).add_child(material)
	job_manager.create_job(material.position, layer, 'material', material.get_path())
