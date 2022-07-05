extends "res://skrypty/wepon.gd"

var unchargedBow = preload("res://grafika/itemy/bow2.png")
var chargedBow = preload("res://grafika/itemy/bow1.png")
onready var wepon = get_node("/root/MainScene/Player/WeponHolder")

func _ready():
	minDamage = 20
	maxDamage = 30
	fireSpeed = 1.2
	bulletRange = 2
	typeOfBullet = "arrow"
	textureChangeAfterShot = true
	title = "Wooden Bow"
	price = 60

func _process(delta):
	if get_parent().name == "WeponHolder":
		texture = unchargedBow
	else:
		texture = chargedBow

func changeGraphic():
	var weponTexture = wepon.get_wepon()
	weponTexture.texture = unchargedBow
	yield(get_tree().create_timer(0.2), "timeout")
	weponTexture.texture = chargedBow
