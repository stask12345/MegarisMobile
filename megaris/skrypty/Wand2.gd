extends wepon


func _ready():
	minDamage = 40
	maxDamage = 60
	fireSpeed = 2
	bulletRange = 0.45
	typeOfBullet = "magic2"
	title = "Fire Wand"
	description = ""
	price = 95
	tier = 4

func _process(_delta):
	if get_parent().name == "WeponHolder":
		rotation_degrees = 270
	else: 
		if "Slot" in get_parent().name: rotation_degrees = 315
