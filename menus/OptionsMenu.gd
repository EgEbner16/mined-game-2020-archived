extends CanvasLayer

class_name OptionsMenus

var state_active = false

func _ready():
	$ColorRect.hide()
	self.state_active = false
	self.set_process(false)

func open():
	print('Open Options Menu')
	$ColorRect.show()
	self.state_active = true
	self.set_process(true)
	get_tree().paused = true

func close():
	$ColorRect.hide()
	self.state_active = false
	self.set_process(false)
	get_tree().paused = false

func change_state():
	if state_active:
		self.close()
	else:
		self.open()

func _on_Close_pressed():
	self.close()

func _on_ExitGame_pressed():
	print('BLAMO')
	if get_parent().name == 'HUD':
		get_tree().change_scene("res://Main.tscn")
	else:
		get_tree().quit()

func _input(event):
	if event.is_action_released("display_options"):
		self.change_state()


func _on_SaveGame_pressed():
	GlobalSaveManager.save_game()


func _on_LoadGame_pressed():
	GlobalSaveManager.load_game()
