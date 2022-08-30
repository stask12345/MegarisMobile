extends skill

func _ready():
	bought = true #tylko dla skilli w training grounds
	if bought: applyEffect()
	description = "Body Training I: \n+10 Max Hp"
	costOfSkill = 25
	trainingGrounds = true

func applyEffect():
	playerStatsHp.maxHp += 0 #Wyświetla się dostępny do zakupu skill, czyli upgrady są tak naprawdę gorsze o 1 stopień
	playerStatsHp.hp += 0

func buy():
	if playerStats.crystals >= costOfSkill:
		playerStats.crystals -= costOfSkill
		applyEffect()
		get_node("/root/MainScene/Floor/TrainingCamp/Market").levelOfHpSkill += 1
		get_node("/root/MainScene/Floor/TrainingCamp/Market").placeHpSkills()
		queue_free()

