extends skill

func _ready():
	bought = true #tylko dla skilli w training grounds
	if bought: applyEffect()
	description = "Body Training IV: \n+40 Max Hp"
	costOfSkill = 100
	trainingGrounds = true

func applyEffect():
	playerStatsHp.maxHp += 30 #Wyświetla się dostępny do zakupu skill, czyli upgrady są tak naprawdę gorsze o 1 stopień
	playerStatsHp.hp += 30

func buy():
	get_node("/root/MainScene/Floor/TrainingCamp/Market").levelOfHpSkill += 1
	get_node("/root/MainScene/Floor/TrainingCamp/Market").placeHpSkills()
	
	playerStatsHp.maxHp -= 30 #By przy kupowaniu kilku upg pod rząd hp się nie nawarstwiało
	playerStatsHp.hp -= 30
	
	queue_free()
