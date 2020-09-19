extends Control


onready var progress_bar = $HBoxContainer/VBoxContainer/ProgressBar


func _on_Timer_timeout():
#	get_tree().change_scene("res://game/Game.tscn")
	GlobalSceneLoader.goto_scene("res://game/Game.tscn")
	pass
