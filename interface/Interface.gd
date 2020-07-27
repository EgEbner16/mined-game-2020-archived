extends CanvasLayer

class_name Interface

var state_active = false

func _ready():
	$ColorRect.hide()
	state_active = false
	self.set_process(false)

func open():
	$ColorRect.show()
#	print('open')
	self.set_process(true)
	state_active = true

func close():
	$ColorRect.hide()
#	print('close')
	state_active = false
	self.set_process(false)

func change_state():
	if state_active:
		self.close()
	else:
		self.open()
