extends State

class_name StateIdle

func _ready():
	pass

func _process(delta):
	if self.path.size() > 0:
		new_state = 'moving'
