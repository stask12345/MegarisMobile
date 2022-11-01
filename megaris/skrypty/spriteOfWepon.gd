extends Sprite

func saveCurrent():
	var node_data = {
		"type": "normal",
		"texture.resource_path": texture.resource_path,
		"self_modulate.a": self_modulate.a,
		"nodePath": get_path()
	}
	return node_data
