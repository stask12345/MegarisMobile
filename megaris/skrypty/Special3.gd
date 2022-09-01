extends wepon


func _ready():
	minDamage = 45
	maxDamage = 60
	fireSpeed = 2
	bulletRange = 3
	typeOfBullet = "special3"
	title = "Necromancer Wand"
	description = ""
	price = 175
	costOfSkill = 55
	tier = 5

func _process(delta):
	if get_parent().name == "WeponHolder":
		rotation_degrees = 0
	else: 
		if "Slot" in get_parent().name: rotation_degrees = 45
