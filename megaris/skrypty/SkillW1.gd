extends skill

func _ready():
	bought = true #tylko dla skilli w training grounds
	if bought: applyEffect()
	description = "Wepon Mastery I: \n+4% Damage Increase"
	costOfSkill = 25
	trainingGrounds = true

func applyEffect():
	playerStats.maxDamageIncrease = 1 #Wyświetla się dostępny do zakupu skill, czyli upgrady są tak naprawdę gorsze o 1 stopień

func buy():
	if playerStats.crystals >= costOfSkill:
		playerStats.crystals -= costOfSkill
		applyEffect()
		get_node("/root/MainScene/Floor/TrainingCamp/Market").levelOfWeponSkill += 1
		get_node("/root/MainScene/Floor/TrainingCamp/Market").placeWeponSkills()
		queue_free()

