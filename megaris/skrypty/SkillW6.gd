extends skill

func _ready():
	bought = true #tylko dla skilli w training grounds
	if bought: applyEffect()
	description = "Wepon Mastery V: \n+20% Damage Increase"
	costOfSkill = 1
	trainingGrounds = true
	rewardSkill = true

func applyEffect():
	playerStats.maxDamageIncrease = 1.2

func buy():
	applyEffect()
	get_node("/root/MainScene/Floor/TrainingCamp/Market").levelOfWeponSkill += 1
	get_node("/root/MainScene/Floor/TrainingCamp/Market").placeWeponSkills()
	queue_free()
