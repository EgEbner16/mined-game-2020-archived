extends Node2D

class_name Equipment

var constructed: float = 0.0

var resource_handler: ResourceHandler = ResourceHandler.new()

onready var entity: Entity = $Entity

func _ready():
	pass

func _physics_process(delta):
	if constructed < 100.0:
		var num = 0.5 + (constructed / 100) / 2
		$AnimatedSprite.modulate = Color(num,1.0,num,num)
		$AnimatedSprite.playing = false
	else:
		$AnimatedSprite.modulate = Color(1.0,1.0,1.0,1.0)
		entity.on = true
		$AnimatedSprite.playing = true

func set_constructed():
	constructed = 100.0
	entity.on = true

