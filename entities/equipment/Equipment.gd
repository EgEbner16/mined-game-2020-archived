extends Node2D


class_name Equipment


var layer_number: int = 0
var constructed: float = 0.0
var type: String = ''
var verbose_name: String = ''
var verbose_description: String = ''
var resource_handler: ResourceHandler = ResourceHandler.new()


onready var entity: Entity = $Entity
onready var job_manager: JobManager = get_node('/root/Game/World/JobManager')


func _ready():
	self.add_to_group('equipment')
	self.add_to_group('%s_equipment' % self.type)
	self.name = self.type
	print(self.name)
	if self.type == 'elevator_up':
		self.add_to_group('Persist_80')
	else:
		self.add_to_group('Persist')
	if self.constructed < 100.0 and self.type != 'elevator_up':
		var layer = get_node('/root/Game/World/Layer_%s' % self.layer_number)
		job_manager.create_job(self.position, layer, 'equipment', self.get_path())



func _physics_process(delta):
	if constructed < 100.0:
		var num = 0.0 + (constructed / 100)
		$AnimatedSprite.modulate = Color(num,(1.5 - (num /2)),num,(0.5 + (num /2)))
		$AnimatedSprite.playing = false
	else:
		$AnimatedSprite.modulate = Color(1.0,1.0,1.0,1.0)
		entity.on = true
		$AnimatedSprite.playing = true


func set_constructed():
	constructed = 100.0
	entity.on = true
	$AnimatedSprite.playing = true

