extends wepon


var unchargedBow = preload("res://grafika/itemy/bow3.png")
var chargedBow = preload("res://grafika/itemy/bow5.png")
onready var wepon = get_node("/root/MainScene/Player/WeponHolder")

func _ready():
	minDamage = 30
	maxDamage = 70
	fireSpeed = 0.9
	bulletRange = 2
	typeOfBullet = "arrow"
	textureChangeAfterShot = true
	title = "Hunter Bow"
	price = 100

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
