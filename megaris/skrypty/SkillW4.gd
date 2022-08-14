extends skill

func _ready():
	bought = true #tylko dla skilli w training grounds
	if bought: applyEffect()
	description = "Wepon Mastery IV: \n+8 Max Attack"
	costOfSkill = 1
	trainingGrounds = true

func applyEffect():
	playerStats.maxDamageIncrease = 6

func buy():
	if playerStats.crystals >= costOfSkill:
		playerStats.crystals -= costOfSkill
		applyEffect()
		get_node("/root/MainScene/Floor/TrainingCamp/Market").levelOfWeponSkill += 1
		get_node("/root/MainScene/Floor/TrainingCamp/Market").placeSkills()
		queue_free()
