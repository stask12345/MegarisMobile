extends skill

func _ready():
	if bought and !get_node("%Skill13Upper").bought: applyEffect()
	description = "Alchemist: \n Healing Potion II On Start"
	costOfSkill = 20

func applyEffect():
	playerStats.levelOfItem = 1

func buy():
	applyEffect()
	get_node("/root/MainScene/Floor/SpawnPoint").ChangeStartingItems()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
