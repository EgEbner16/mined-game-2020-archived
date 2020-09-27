extends Node


func save_game():
	var save_game = File.new()
	save_game.open('user://savegame.save', File.WRITE)
	for i in range(0, 10):
		save_game = save_node_group('Persist_%s' % i, save_game)
	save_game = save_node_group('Persist', save_game)
	save_game.close()


func save_node_group(group: String, save_game):
	var save_nodes = get_tree().get_nodes_in_group(group)
	for node in save_nodes:
		if node_can_be_saved(node):
			save_game.store_line(to_json(node.call('save_object')))
	return save_game


func node_can_be_saved(node):
	if node.filename.empty():
		print('persistent node "%s" is not an instanced scene, skipped' % node.name)
		return false
	elif !node.has_method('save_object'):
		print('persistent node "%s" is missing a save() function, skipped' % node.name)
		return false
	else:
		return true


func load_game():
	var save_game = File.new()
	if not save_game.file_exists('user://savegame.save'):
		print('Failed to find file')
		return # Error! We don't have a save to load.

	for i in range(0, 10):
		free_node_group('Persist_%s' % i)
	free_node_group('Persist')

	get_node('/root/Game/World/JobManager').on_load_game()

	save_game.open('user://savegame.save', File.READ)
	while save_game.get_position() < save_game.get_len():
		var node_data = parse_json(save_game.get_line())

		var new_object = load(node_data['filename']).instance()

		for i in node_data.keys():
			if i == 'filename' or i == 'parent':
				continue
			if typeof(node_data[i]) == 18:
				if 'type' in node_data[i]:
					if node_data[i]['type'] == 'Vector2':
						new_object.set(i, Vector2(node_data[i]['x'], node_data[i]['y']))
				else:
					new_object.set(i, node_data[i])
			else:
				new_object.set(i, node_data[i])

		get_node(node_data['parent']).add_child(new_object)

		if new_object.has_method('load_object'):
			new_object.call('load_object')


	save_game.close()


func free_node_group(group: String):
	var save_nodes = get_tree().get_nodes_in_group(group)
	for i in save_nodes:
		if i != null:
			# Note this could be dangerous as queue free is safer
			i.free()


func save_vector2(vector2: Vector2):
	var vector2_dict = {
		'type': 'Vector2',
		'x': vector2.x,
		'y': vector2.y,
	}
	return vector2_dict
