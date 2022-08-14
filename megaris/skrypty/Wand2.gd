extends wepon


func _ready():
	minDamage = 50
	maxDamage = 80
	fireSpeed = 2
	bulletRange = 0.5
	typeOfBullet = "magic2"
	title = "Fire Wand"
	description = ""
	price = 120

func _process(_delta):
	if get_parent().name == "WeponHolder":
		rotation_degrees = 270
	else: 
		if "Slot" in get_parent().name: rotation_degrees = 315
