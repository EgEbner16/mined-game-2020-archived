extends Node


func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		if node.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		var node_data = node.call("save")

		save_game.store_line(to_json(node_data))
	save_game.close()


func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		print('Failed to find file')
		return # Error! We don't have a save to load.

	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()

	save_game.open("user://savegame.save", File.READ)
	while save_game.get_position() < save_game.get_len():
		var node_data = parse_json(save_game.get_line())

		var new_object = load(node_data["filename"]).instance()

		for i in node_data.keys():
			if i == "filename" or i == "parent":
				continue
			if typeof(node_data[i]) == 18:
				if 'type' in node_data[i]:
					if node_data[i]['type'] == 'Vector2':
						new_object.set(i, Vector2(node_data[i]['x'], node_data[i]['y']))
				else:
					new_object.set(i, node_data[i])
			else:
				new_object.set(i, node_data[i])

		get_node(node_data["parent"]).add_child(new_object)

	save_game.close()


func save_vector2(vector2: Vector2):
	var vector2_dict = {
		'type': 'Vector2',
		'x': vector2.x,
		'y': vector2.y,
	}
	return vector2_dict
