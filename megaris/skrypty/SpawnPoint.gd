extends Sprite

onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")

var sword2 = preload("res://instances/Wepons/Sword2.tscn")
var healingPotion2 = preload("res://instances/Items/PotionHealing2.tscn")
var healingPotion3 = preload("res://instances/Items/PotionHealing3.tscn")

func _ready():
	ChangeStartingItems()

func ChangeStartingItems():
	if playerStats.levelOfWepon == 1:
		var itemToAdd = sword2.instance()
		if get_node("ItemTable/KinematicBody2D2").get_child_count() == 1: get_node("ItemTable/KinematicBody2D2").get_child(0).queue_free()
		get_node("ItemTable/KinematicBody2D2").add_child(itemToAdd)
		get_node("ItemTable").itemInScript = itemToAdd
	
	if playerStats.levelOfItem == 1:
		var itemToAdd = healingPotion2.instance()
		if get_node("Chest").get_child_count() > 1: get_node("Chest").get_child(1).queue_free()
		get_node("Chest").add_child(itemToAdd)
		itemToAdd.visible = false
	
	if playerStats.levelOfItem == 2:
		var itemToAdd = healingPotion3.instance()
		if get_node("Chest").get_child_count() > 1: get_node("Chest").get_child(1).queue_free()
		get_node("Chest").add_child(itemToAdd)
		itemToAdd.visible = false
