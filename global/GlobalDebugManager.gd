extends Node


var debugging = true




func _ready():
	if debugging:
		set_process(true)
	else:
		set_process(false)


func _input(event):
	if debugging:
		if event is InputEventKey:
			if event.scancode == KEY_M:
				var resource_manager: ResourceManager = get_node('/root/Game/ResourceManager')
				resource_manager.gain_capital(100000)
				pass
