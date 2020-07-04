extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.hide()
	self.set_process(false)

func open():
	$ColorRect.show()
	self.set_process(true)
	get_tree().paused = true
	
func close():
	$ColorRect.hide()
	self.set_process(false)
	get_tree().paused = false

func _on_Close_pressed():
	self.close()

func _on_ExitGame_pressed():
	if get_parent().name == 'Game':
		get_tree().change_scene("res://Main.tscn")
	else:
		get_tree().quit()
	
func _process(delta):
	if Input.is_action_just_released("display_options"):
		self.close()

