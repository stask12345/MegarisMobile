extends skill

func _ready():
	bought = true #tylko dla skilli w training grounds
	if bought: applyEffect()
	description = "Body Training V: \n+50 Max Hp"
	costOfSkill = 1
	trainingGrounds = true
	rewardSkill = true

func applyEffect():
	playerStatsHp.maxHp += 50 #Wyświetla się dostępny do zakupu skill, czyli upgrady są tak naprawdę gorsze o 1 stopień
	playerStatsHp.hp += 50

func buy():
	if playerStats.crystals >= costOfSkill:
		playerStats.crystals -= costOfSkill
		get_node("/root/MainScene/Floor/TrainingCamp/Market").levelOfHpSkill += 1
		get_node("/root/MainScene/Floor/TrainingCamp/Market").placeHpSkills()
		
		playerStatsHp.maxHp -= 40 #By przy kupowaniu kilku upg pod rząd hp się nie nawarstwiało
		playerStatsHp.hp -= 40
		
		queue_free()
