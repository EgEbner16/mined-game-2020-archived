extends Node2D

onready var resource_handler: ResourceHandler = ResourceHandler.new()

func set_color(color: String) -> void:
	if color == 'red':
		$Sprite.modulate(Color(255,0,0, 255))
	if color == 'green':
		$Sprite.modulate(Color(0,255,0, 255))
	if color == 'blue':
		$Sprite.modulate(Color(0,0,255, 255))


