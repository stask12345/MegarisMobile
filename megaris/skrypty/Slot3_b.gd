extends Sprite

func get_item_for_save():
	if get_child_count() > 1:
		return get_child(1).filename
	else:
		return null

func get_wepon_upgrade():
	if get_child_count() > 1:
		if get_child(1) is wepon:
			return get_child(1).upgradeLevel
		if !get_child(1) is wepon:
			return 0
	if get_child_count() == 1:
		return 0

func saveCurrent():
	var node_data = {
		"type": "itemSlot3",
		"wepon": get_item_for_save(),
		"upgrade": get_wepon_upgrade(),
		"nodePath": get_path()
	}
	return node_data
