extends Node

# Persist_# or Persist node group is both saved and loaded
# Purge node group is removed when a game is loaded

# Persist objects will load in numberical order then load all persist objects that are not in the group after.

func save_game():
	var save_game = File.new()
	save_game.open('user://savegame.save', File.WRITE)
	for i in range(0, 99):
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

func call_method_on_all_nodes(node, method):
	for n in node.get_children():
		if n.get_child_count() > 0:
			if n.has_method(method):
				n.call(method)
			call_method_on_all_nodes(n, method)
		else:
			if n.has_method(method):
				n.call(method)

func load_game():
	var save_game = File.new()
	if not save_game.file_exists('user://savegame.save'):
		print('Failed to find file')
		return # Error! We don't have a save to load.

	for i in range(0, 99):
		free_node_group('Persist_%s' % i)
	free_node_group('Persist')
	free_node_group('Purge')

	call_method_on_all_nodes(get_node('/root'), 'on_load_game')

	save_game.open('user://savegame.save', File.READ)
	while save_game.get_position() < save_game.get_len():
		var node_data = parse_json(save_game.get_line())

		var new_object = load(node_data['filename']).instance()

		if new_object.has_method('load_object'):
			if 'object_dict' in node_data:
				new_object.load_object(node_data['object_dict'])
			else:
				new_object.load_object()

		for i in node_data.keys():
			if i == 'filename' or i == 'parent' or i == 'object_dict':
				continue
#			print('%s : %s' % [i, node_data[i]])
			if typeof(node_data[i]) == 18:
				if 'type' in node_data[i]:
					if node_data[i]['type'] == 'Vector2':
						new_object.set(i, self.load_vector2(node_data[i]))
					else:
						new_object.set(i, node_data[i])
				else:
					new_object.set(i, node_data[i])
			else:
				new_object.set(i, node_data[i])

		get_node(node_data['parent']).add_child(new_object)

		# Method called after object enters the scene tree
		if new_object.has_method('after_load_object'):
			new_object.after_load_object()

	call_method_on_all_nodes(get_node('/root'), 'on_after_load_game')

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

func load_vector2(object_dict):
	return Vector2(object_dict['x'], object_dict['y'])
