extends wepon
onready var wepon = get_node("/root/MainScene/Player/WeponHolder")

func _ready():
	minDamage = 25
	maxDamage = 35
	fireSpeed = 0.8
	bulletRange = 0.3
	typeOfBullet = "pircing"
	textureChangeAfterShot = true
	title = "Hunter Spear"
	price = 90
	tier = 3

func _process(_delta):
	if get_parent().name == "WeponHolder":
		rotation_degrees = 270
	else: 
		if "Slot" in get_parent().name: rotation_degrees = 315

func changeGraphic():
	var weponTexture = wepon.get_wepon()
	weponTexture.position.x = 20
	yield(get_tree().create_timer(0.3), "timeout")
	weponTexture.position.x = -10
