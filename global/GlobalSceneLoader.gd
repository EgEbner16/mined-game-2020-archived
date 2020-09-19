extends Node


var loader
var wait_frames
var time_max = 100 # msec
var current_scene


func goto_scene(path): # game requests to switch to this scene
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)
	print('Current Scene %s' % current_scene.name)
	loader = ResourceLoader.load_interactive(path)
	if loader == null: # check for errors
#		show_error()
		return
	set_process(true)

	wait_frames = 1


func _process(time):
	if loader == null:
		# no need to process anymore
		set_process(false)
		return

	if wait_frames > 0: # wait for frames to let the "loading" animation to show up
		wait_frames -= 1
		return

		# poll your loader
	var err = loader.poll()

	if err == ERR_FILE_EOF: # load finished
		var resource = loader.get_resource()
		loader = null
		current_scene.queue_free() # get rid of the old scene
		set_new_scene(resource)
	elif err == OK:
		update_progress()
	else: # error during loading
#			show_error()
		loader = null

	var t = OS.get_ticks_msec()
	while OS.get_ticks_msec() < t + time_max: # use "time_max" to control how much time we block this thread
		pass


func update_progress():
	var progress = float(loader.get_stage()) / loader.get_stage_count()
	# update your progress bar?
	current_scene.progress_bar.value = progress * 100

#	# or update a progress animation?
#	var len = get_node("animation").get_current_animation_length()
#
#	# call this on a paused animation. use "true" as the second parameter to force the animation to update
#	get_node("animation").seek(progress * len, true)


func set_new_scene(scene_resource):
	current_scene = scene_resource.instance()
	get_node("/root").add_child(current_scene)
