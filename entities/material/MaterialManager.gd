extends Node

class_name MaterialManager

const MATERIAL = preload("res://entities/material/Material.tscn")

onready var job_manager: JobManager = get_node('/root/Game/World/JobManager')

func _ready():
	pass

func create_material(world_position: Vector2, layer) -> void:
	var material: GameMaterial = MATERIAL.instance()
	material.add_to_group('material')
	material.position = world_position
	material.resource_handler.material = 3000
	get_node('/root/Game/World/Layer_%s' % layer.number).add_child(material)
	job_manager.create_job(material.position, layer, 'material', material.get_path())
