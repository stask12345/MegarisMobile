extends wepon


var unchargedBow = preload("res://grafika/itemy/bow8.png")
var chargedBow = preload("res://grafika/itemy/bow10.png")
onready var wepon = get_node("/root/MainScene/Player/WeponHolder")

func _ready():
	minDamage = 30
	maxDamage = 70
	fireSpeed = 0.9
	bulletRange = 2
	typeOfBullet = "arrow double triple"
	textureChangeAfterShot = true
	title = "Hunter Bow"
	price = 100
	rangeDestroy = false

func _process(_delta):
	if get_parent().name == "WeponHolder":
		texture = unchargedBow
	else:
		texture = chargedBow
	
	if "Slot" in get_parent().name: scale = Vector2(0.8,0.8)
	else: scale = Vector2(1,1)

func changeGraphic():
	var weponTexture = wepon.get_wepon()
	weponTexture.texture = unchargedBow
	yield(get_tree().create_timer(0.2), "timeout")
	weponTexture.texture = chargedBow
