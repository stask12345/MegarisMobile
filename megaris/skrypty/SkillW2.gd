extends skill

func _ready():
	bought = true #tylko dla skilli w training grounds
	if bought: applyEffect()
	description = "Wepon Mastery II: \n+8% Damage Increase"
	costOfSkill = 50
	trainingGrounds = true

func applyEffect():
	playerStats.maxDamageIncrease = 1.04

func buy():
	applyEffect()
	get_node("/root/MainScene/Floor/TrainingCamp/Market").levelOfWeponSkill += 1
	get_node("/root/MainScene/Floor/TrainingCamp/Market").placeWeponSkills()
	queue_free()
