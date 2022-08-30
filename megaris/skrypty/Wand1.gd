extends wepon


func _ready():
	minDamage = 2
	maxDamage = 3
	fireSpeed = 0.2
	bulletRange = 0.4
	typeOfBullet = "magic"
	title = "Water Wand"
	description = ""
	price = 60
	costOfSkill = 20
	tier = 3

func _process(_delta):
	if get_parent().name == "WeponHolder":
		rotation_degrees = 270
	else: 
		if "Slot" in get_parent().name: rotation_degrees = 315
