extends skill

func _ready():
	bought = true #tylko dla skilli w training grounds
	if bought: applyEffect()
	description = "Wepon Mastery V: \n+20% Damage Increase"
	costOfSkill = 150
	trainingGrounds = true

func applyEffect():
	playerStats.maxDamageIncrease = 1.16

func buy():
	if playerStats.crystals >= costOfSkill:
		playerStats.crystals -= costOfSkill
		applyEffect()
		get_node("/root/MainScene/Floor/TrainingCamp/Market").levelOfWeponSkill += 1
		get_node("/root/MainScene/Floor/TrainingCamp/Market").placeWeponSkills()
		queue_free()
