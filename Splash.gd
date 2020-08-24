extends Control

func _input(event):
	if event.is_action_released("ui_cancel"):
		get_tree().change_scene("res://menus/MainMenu.tscn")

func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://menus/MainMenu.tscn")
