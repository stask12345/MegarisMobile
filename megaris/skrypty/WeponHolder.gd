extends Node

var whiteGraphic = load("res://grafika/white.png")

func _ready():
	pass

func equipWepon():
	unEquipGraphic()
	var playerHand = get_wepon_in_right_place()
	var wepon = get_child(0)
	playerHand.texture = wepon.texture
	playerHand.self_modulate.a = 1

func get_wepon_in_right_place():
	var wepon = get_child(0)
	var playerHand
	if "Sword" in wepon.name or "Mace" in wepon.name: playerHand = get_parent().get_parent().get_parent().get_node("Player/WeponHolder/swordRotation/spriteOfWepon")
	if "Bow" in wepon.name: playerHand = get_parent().get_parent().get_parent().get_node("Player/WeponHolder/bowRotation/spriteOfWepon")
	if "Spear" in wepon.name or "Wand" in wepon.name: playerHand = get_parent().get_parent().get_parent().get_node("Player/WeponHolder/spearRotation/spriteOfWepon")
	return playerHand

func unEquipGraphic():
	var playerHand = get_parent().get_parent().get_parent().get_node("Player/WeponHolder").get_wepon()
	if playerHand != null:
		playerHand.texture = whiteGraphic
		playerHand.self_modulate.a = 0
