extends Node2D


func _enter_tree():
	loadData()

func saveData():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("saveGroup")
	for node in save_nodes:
		if !node.has_method("save"): #nie ma funkcji save()
			break
		if node.filename.empty(): #nie jest obiektem który można zinstancjować
			var node_data = node.call("save")
			save_game.store_line(to_json(node_data))
			save_game.close()
		if !node.filename.empty():
			pass

func loadData():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://savegame.save", File.READ)
	while save_game.get_position() < save_game.get_len():#wczytowanie danych, a nie obiektów do skopiowania!
		var node_data = parse_json(save_game.get_line())
		for i in node_data.keys():
			if i != "nodePath":
				get_node(node_data["nodePath"]).set(i,node_data[i])
	pass
