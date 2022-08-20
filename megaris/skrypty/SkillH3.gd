extends skill

func _ready():
	bought = true #tylko dla skilli w training grounds
	if bought: applyEffect()
	description = "Body Training III: \n+30 Max Hp"
	costOfSkill = 1
	trainingGrounds = true

func applyEffect():
	playerStatsHp.maxHp += 20 #Wyświetla się dostępny do zakupu skill, czyli upgrady są tak naprawdę gorsze o 1 stopień
	playerStatsHp.hp += 20

func buy():
	if playerStats.crystals >= costOfSkill:
		playerStats.crystals -= costOfSkill
		get_node("/root/MainScene/Floor/TrainingCamp/Market").levelOfHpSkill += 1
		get_node("/root/MainScene/Floor/TrainingCamp/Market").placeHpSkills()
		
		playerStatsHp.maxHp -= 20 #By przy kupowaniu kilku upg pod rząd hp się nie nawarstwiało
		playerStatsHp.hp -= 20
		
		queue_free()
