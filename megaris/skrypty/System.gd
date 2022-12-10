extends Node2D

func _enter_tree():
	loadData()
	if get_node("/root/MainScene/EffectGenerator").loadSave:
		if get_node("/root/MainScene/EffectGenerator").duringCastle:
			get_node("/root/MainScene/GeneratedTerrain").loadCastle = true
			get_node("/root/MainScene/EffectGenerator").loadedData = true #By w terraingeneratorze w castle załadował
		else:
			get_node("/root/MainScene/GeneratedTerrain").loadSave = true
	if !get_node("/root/MainScene/EffectGenerator").loadSave:
		$Floor/SpawnPoint.potionTaken = false
		$Floor/SpawnPoint.swordTaken = false

func saveEntireGame():
	saveData()
	saveDataCurrent()
	if get_node("/root/MainScene/EffectGenerator").duringCastle:
		get_node("/root/MainScene/Castle/GeneretedTerrain").saveElements()
		get_node("/root/MainScene/Castle/GeneretedTerrain").saveMonsters()
	else:
		get_node("/root/MainScene/GeneratedTerrain").saveElements()
		get_node("/root/MainScene/GeneratedTerrain").saveMonsters()

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
		if !node.filename.empty():
			pass
	save_game.close()

func saveDataCurrent(): #zapis aktualnej rozgrywki grupa saveGroupCurrent, funkcja saveCurrent
	var save_game = File.new()
	save_game.open("user://savegameCurrent.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("saveGroupCurrent")
	for node in save_nodes:
		if !node.has_method("saveCurrent"): #nie ma funkcji save()
			break
		if node.filename.empty(): #nie jest obiektem który można zinstancjować
			var node_data = node.call("saveCurrent")
			save_game.store_line(to_json(node_data))
		if !node.filename.empty():
			pass
	save_game.close()

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
	save_game.close()
	pass

func loadDataCurrent():
	var save_game = File.new()
	if not save_game.file_exists("user://savegameCurrent.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://savegameCurrent.save", File.READ)
	while save_game.get_position() < save_game.get_len():#wczytowanie danych, a nie obiektów do skopiowania!
		var node_data = parse_json(save_game.get_line())
		if node_data["type"] == "normal":
			for i in node_data.keys():
				if i != "nodePath" and i != "type":
					get_node(node_data["nodePath"]).set(i,node_data[i])
		
		if node_data["type"] == "player":
			if get_node("/root/MainScene/EffectGenerator").duringBossFight:
				get_node("/root/MainScene/Player").position = Vector2(-658, -3266)
				get_node("/root/MainScene/EffectGenerator").duringBossFight = false
				if get_node("/root/MainScene/EffectGenerator").winnedLastFight:
					get_node("/root/MainScene/Castle/Terrain/BossRoom/Area2DBoss/CollisionShape2D").disabled = true
					get_node("/root/MainScene/Castle/Terrain/BossRoom/Area2DBoss").monitoring = false
					get_node("/root/MainScene/Castle/Terrain/BossRoom/Area2DBoss").monitorable = false
					get_node("/root/MainScene/Castle/Terrain/BossRoom/P1").closeExit()
					get_node("/root/MainScene/Castle/Terrain/BossRoom/P2").closeExit()
					get_node("/root/MainScene/Castle/Terrain/BossRoom/Ladders/LadderLong").visible = true
					get_node("/root/MainScene/Castle/Terrain/BossRoom/Ladders/LadderLong/Area2D/CollisionShape2D").disabled = false
					get_node("/root/MainScene/CanvasModulate").color = Color.white
					get_node("/root/MainScene/Player/Light2D").energy = 0
					get_node("/root/MainScene/Player").position = Vector2(0, -3266)
				saveData()
			else:
				if get_node("/root/MainScene/EffectGenerator").duringRewards:
					get_node("/root/MainScene/EffectGenerator").getPlayerToRewardRoomLoad()
				else:
					get_node("/root/MainScene/Player").position = Vector2(node_data["pos_x"],node_data["pos_y"])
		
		if node_data["type"] == "wepon":
			if node_data["wepon"] != null:
				var w = load(node_data["wepon"]).instance()
				get_node("/root/MainScene/CanvasLayer/Control4/WeponHolder").add_child(w)
				get_node("/root/MainScene/CanvasLayer/Control4/WeponHolder").equipWepon()
				if node_data["upgrade"] == 1:
					w.upgradeLevel += 1
					w.maxDamage += 5
				if node_data["upgrade"] == 2:
					w.upgradeLevel += 2
					w.maxDamage += 10
		
		if node_data["type"] == "itemSlot1":
			if node_data["wepon"] != null:
				var i = load(node_data["wepon"]).instance()
				get_node("/root/MainScene/CanvasLayer/Control5/Slot1_b").add_child(i)
				if node_data["upgrade"] == 1:
					i.upgradeLevel += 1
					i.maxDamage += 5
				if node_data["upgrade"] == 2:
					i.upgradeLevel += 2
					i.maxDamage += 10
		
		if node_data["type"] == "itemSlot2":
			if node_data["wepon"] != null:
				var i = load(node_data["wepon"]).instance()
				get_node("/root/MainScene/CanvasLayer/Control5/Slot2_b").add_child(i)
				if node_data["upgrade"] == 1:
					i.upgradeLevel += 1
					i.maxDamage += 5
				if node_data["upgrade"] == 2:
					i.upgradeLevel += 2
					i.maxDamage += 10
		
		if node_data["type"] == "itemSlot3":
			if node_data["wepon"] != null:
				var i = load(node_data["wepon"]).instance()
				get_node("/root/MainScene/CanvasLayer/Control5/Slot3_b").add_child(i)
				if node_data["upgrade"] == 1:
					i.upgradeLevel += 1
					i.maxDamage += 5
				if node_data["upgrade"] == 2:
					i.upgradeLevel += 2
					i.maxDamage += 10
	
	save_game.close()
	
	get_node("/root/MainScene/CanvasLayer/Control3").updatePlayerLook()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		saveEntireGame()
	else:
		if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
			saveEntireGame()
		else:
			if what == NOTIFICATION_WM_FOCUS_OUT:
				saveEntireGame()


func _on_MainScene_child_exiting_tree(node):
#	if !saved:
#		print("pp3")
#		saved = true
#		saveEntireGame()
	pass

