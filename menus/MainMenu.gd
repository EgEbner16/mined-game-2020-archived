extends CanvasLayer

func _ready():
	var options_menu = load("res://menus/OptionsMenu.tscn")
	add_child(options_menu.instance())

func _on_Campaign_pressed():
	get_tree().change_scene("res://game/Game.tscn")

func _on_Sandbox_pressed():
	get_tree().change_scene("res://game/Game.tscn")

func _on_Options_pressed():
	$OptionsMenu.open()

func _on_Exit_pressed():
	get_tree().quit()



