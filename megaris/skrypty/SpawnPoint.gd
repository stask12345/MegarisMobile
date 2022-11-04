extends Sprite

onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var visibility_notifier := $VisibilityNotifier2D

var sword2 = preload("res://instances/Wepons/Sword2.tscn")
var healingPotion2 = preload("res://instances/Items/PotionHealing2.tscn")
var healingPotion3 = preload("res://instances/Items/PotionHealing3.tscn")

var swordTaken = false
var potionTaken = false

func _ready():
	ChangeStartingItems()
	visibility_notifier.connect("screen_entered",self,"show")
	visibility_notifier.connect("screen_exited",self,"hide")
	visible = false

func ChangeStartingItems():
	if playerStats.levelOfWepon == 1 and !swordTaken:
		var itemToAdd = sword2.instance()
		if get_node("startingTable/KinematicBody2D2").get_child_count() == 1: get_node("startingTable/KinematicBody2D2").get_child(0).queue_free()
		get_node("startingTable/KinematicBody2D2").add_child(itemToAdd)
		get_node("startingTable").itemInScript = itemToAdd
	
	if playerStats.levelOfItem == 1 and !potionTaken:
		var itemToAdd = healingPotion2.instance()
		if get_node("startingChest").get_child_count() > 2: 
			get_node("startingChest").get_child(2).queue_free()
			get_node("startingChest").add_child(itemToAdd)
		itemToAdd.visible = false
	
	if playerStats.levelOfItem == 2 and !potionTaken:
		var itemToAdd = healingPotion3.instance()
		if get_node("startingChest").get_child_count() > 1: get_node("startingChest").get_child(1).queue_free()
		get_node("startingChest").add_child(itemToAdd)
		itemToAdd.visible = false
	
	if swordTaken:
		if get_node("startingTable/KinematicBody2D2").get_child_count() == 1: 
			get_node("startingTable/KinematicBody2D2").get_child(0).queue_free()
			get_node("startingTable").itemInScript = null
	
	if potionTaken:
		if get_node("startingChest").get_child_count() > 2: 
			get_node("startingChest").get_child(2).queue_free()
			get_node("startingChest").frame = 2

func save():
	var node_data = {
		"swordTaken": swordTaken,
		"potionTaken": potionTaken,
		"nodePath": get_path()
	}
	return node_data
