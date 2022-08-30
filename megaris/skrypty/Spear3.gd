extends wepon
onready var wepon = get_node("/root/MainScene/Player/WeponHolder")

func _ready():
	minDamage = 30
	maxDamage = 40
	fireSpeed = 1.2
	bulletRange = 0.25
	typeOfBullet = "pircing double"
	textureChangeAfterShot = true
	title = "Royal Trident"
	price = 145
	tier = 4

func _process(delta):
	if get_parent().name == "WeponHolder":
		rotation_degrees = 270
	else: 
		if "Slot" in get_parent().name: rotation_degrees = 315

func changeGraphic():
	var weponTexture = wepon.get_wepon()
	weponTexture.position.x = 20
	yield(get_tree().create_timer(0.3), "timeout")
	weponTexture.position.x = -10
