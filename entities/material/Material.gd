extends Node2D


class_name GameMaterial


onready var job_manager: JobManager = get_node('/root/Game/World/JobManager')


var resource_handler: ResourceHandler = ResourceHandler.new()


func save_object():
	var object_dict = {
		'resource_handler': self.resource_handler.save_object()
	}
	var save_dict = {
		'filename': get_filename(),
		'parent': get_parent().get_path(),
		'position': GlobalSaveManager.save_vector2(self.position),
		'object_dict': object_dict,
	}
	return save_dict


func load_object(object_dict):
	self.resource_handler.load_object(object_dict['resource_handler'])


func after_load_object():
	pass


func _ready():
	self.add_to_group('Persist')
	$Sprite.modulate = Color(0.3,0.15,0.0,1.0)
	self.add_to_group('material')
	job_manager.create_job(self.position, self.get_parent(), 'material', self.get_path())


func set_color(color: String) -> void:
	if color == 'red':
		$Sprite.modulate(Color(255,0,0, 255))
	if color == 'green':
		$Sprite.modulate(Color(0,255,0, 255))
	if color == 'blue':
		$Sprite.modulate(Color(0,0,255, 255))


