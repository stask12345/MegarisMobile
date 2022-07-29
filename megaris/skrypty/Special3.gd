extends wepon


func _ready():
	minDamage = 50
	maxDamage = 80
	fireSpeed = 2
	bulletRange = 3
	typeOfBullet = "special3"
	title = "Summoner Wand"
	description = ""
	price = 120

func _process(delta):
	if get_parent().name == "WeponHolder":
		rotation_degrees = 0
	else: 
		if "Slot" in get_parent().name: rotation_degrees = 45
