extends wepon


func _ready():
	minDamage = 60
	maxDamage = 80
	fireSpeed = 1
	bulletRange = 1
	typeOfBullet = "magic4"
	title = "Laser Wand"
	description = ""
	price = 260
	tier = 6

func _process(delta):
	if get_parent().name == "WeponHolder":
		rotation_degrees = 270
	else: 
		if "Slot" in get_parent().name: rotation_degrees = 315
