extends wepon


func _ready():
	minDamage = 25
	maxDamage = 30
	fireSpeed = 2
	bulletRange = 3
	typeOfBullet = "special4"
	title = "Summoner Wand"
	description = ""
	price = 80
	costOfSkill = 75
	tier = 3

func _process(delta):
	if get_parent().name == "WeponHolder":
		rotation_degrees = 0
	else: 
		if "Slot" in get_parent().name: rotation_degrees = 45
