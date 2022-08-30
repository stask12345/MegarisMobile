extends "res://skrypty/wepon.gd"

var unchargedBow = preload("res://grafika/itemy/bow2.png")
var chargedBow = preload("res://grafika/itemy/bow1.png")
onready var wepon = get_node("/root/MainScene/Player/WeponHolder")

func _ready():
	minDamage = 15
	maxDamage = 30
	fireSpeed = 1.4
	bulletRange = 2
	typeOfBullet = "arrow"
	textureChangeAfterShot = true
	title = "Basic Bow"
	price = 65
	rangeDestroy = false
	costOfSkill = 20
	tier = 2

func _process(_delta):
	if get_parent().name == "WeponHolder":
		texture = unchargedBow
	else:
		texture = chargedBow

func changeGraphic():
	var weponTexture = wepon.get_wepon()
	weponTexture.texture = unchargedBow
	yield(get_tree().create_timer(0.2), "timeout")
	weponTexture.texture = chargedBow
