extends Node

var whiteGraphic = load("res://grafika/white.png")

func _ready():
	pass

func equipWepon():
	unEquipGraphic()
	var playerHand = get_wepon_in_right_place()
	var weponToEquip = get_child(0)
	playerHand.texture = weponToEquip.texture
	playerHand.self_modulate.a = 1
	if $"../AnvilMenu".visible: $"../AnvilMenu".showArmory()

func get_wepon_in_right_place():
	var weponToEquip = get_child(0)
	var playerHand
	if "Sword" in weponToEquip.name or "Mace" in weponToEquip.name: playerHand = get_parent().get_parent().get_parent().get_node("Player/WeponHolder/swordRotation/spriteOfWepon")
	if "Bow" in weponToEquip.name: playerHand = get_parent().get_parent().get_parent().get_node("Player/WeponHolder/bowRotation/spriteOfWepon")
	if "Spear" in weponToEquip.name or "Wand" in weponToEquip.name: 
		playerHand = get_node("/root/MainScene/Player/WeponHolder/spearRotation/spriteOfWepon")
	return playerHand

func unEquipGraphic():
	var playerHand = get_parent().get_parent().get_parent().get_node("Player/WeponHolder").get_wepon()
	if playerHand != null:
		playerHand.texture = whiteGraphic
		playerHand.self_modulate.a = 0

func get_wepon_for_save():
	if get_child_count() > 0:
		return get_child(0).filename
	else:
		return null

func get_wepon_upgrade():
	if get_child_count() > 0:
		return get_child(0).upgradeLevel
	else:
		return 0

func saveCurrent():
	var node_data = {
		"type": "wepon",
		"wepon": get_wepon_for_save(),
		"upgrade": get_wepon_upgrade(),
		"nodePath": get_path()
	}
	return node_data
