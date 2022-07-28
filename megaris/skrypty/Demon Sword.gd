extends wepon

onready var swordHolder = get_node("/root/MainScene/Player/WeponHolder")
var swordTexture1 = preload("res://grafika/itemy/sword4_1.png")
var swordTexture2 = preload("res://grafika/itemy/sword4_2.png")
var swordTexture3 = preload("res://grafika/itemy/sword4_3.png")
var animating = false

func _ready():
	minDamage = 30
	maxDamage = 45
	fireSpeed = 0.6
	bulletRange = 0.4
	typeOfBullet = "sword demonic"
	title = "Gold Sword"
	description = ""
	price = 150

func _process(delta):
	if !animating and get_parent().name == "WeponHolder":
		animateSword()

func animateSword():
	var sword = swordHolder.get_wepon()
	sword.texture = getSwordTexture(sword)
	if get_parent().name != "WeponHolder":
		animating = false
		$Timer.stop()
		return
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
