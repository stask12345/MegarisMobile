extends wepon

onready var swordHolder = get_node("/root/MainScene/Player/WeponHolder")
var swordTexture1 = preload("res://grafika/itemy/sword4_1.png")
var swordTexture2 = preload("res://grafika/itemy/sword4_2.png")
var swordTexture3 = preload("res://grafika/itemy/sword4_3.png")
var animating = false

func _ready():
	minDamage = 40
	maxDamage = 70
	fireSpeed = 0.9
	bulletRange = 0.4
	typeOfBullet = "sword demonic"
	title = "Demonic Sword"
	description = ""
	price = 200
	tier = 5

func _process(delta):
	if !animating and get_parent().name == "WeponHolder":
		animateSword()
	
	if get_parent().name == "WeponHolder":
		rotation_degrees = 0
	else: 
		if "Slot" in get_parent().name: rotation_degrees = 45

func animateSword():
	if get_parent().name != "WeponHolder":
		animating = false
		$Timer.stop()
		return
	var sword = swordHolder.get_wepon()
	sword.texture = getSwordTexture(sword)
	animating = true
	$Timer.start(1)
	yield($Timer,"timeout")
	print("animuje koloruje")
	animateSword()

func getSwordTexture(sword):
	if sword.texture.resource_path  == swordTexture1.resource_path: 
		return swordTexture2
	if sword.texture.resource_path  == swordTexture2.resource_path: 
		return swordTexture3
	if sword.texture.resource_path  == swordTexture3.resource_path: 
		return swordTexture1
