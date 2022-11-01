extends skill

func _ready():
	if bought: applyEffect()
	description = "Weaponsmith: \nSteel Sword On Start"
	costOfSkill = 75

func applyEffect():
	playerStats.levelOfWepon += 1

func buy():
	applyEffect()
	get_node("/root/MainScene/Floor/SpawnPoint").ChangeStartingItems()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
