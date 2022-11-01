extends wepon


func _ready():
	minDamage = 40
	maxDamage = 50
	fireSpeed = 0.8
	bulletRange = 0.5
	typeOfBullet = "magic3"
	title = "Seeking Wand"
	description = ""
	price = 150
	costOfSkill = 40
	tier = 5

func _process(delta):
	if get_parent().name == "WeponHolder":
		rotation_degrees = 270
	else: 
		if "Slot" in get_parent().name: rotation_degrees = 315
