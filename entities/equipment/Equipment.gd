extends Node2D

class_name Equipment

var constructed: float = 0.0

var resource_handler: ResourceHandler = ResourceHandler.new()

onready var entity: Entity = $Entity

func _ready():
	pass

func _physics_process(delta):
	if constructed < 100.0:
		var num = 155 + int(constructed)
		$AnimatedSprite.modulate(Color(num,255,num,num))

func set_constructed():
	constructed = 100.0
	entity.on = true

