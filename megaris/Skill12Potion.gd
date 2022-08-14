extends skill

func _ready():
	if bought and !get_node("%Skill13Upper").bought: applyEffect()
	description = "Better Potions: \n Healing Potion II On Start"

func applyEffect():
	playerStats.levelOfItem += 1

func buy():
	applyEffect()
	get_node("/root/MainScene/Floor/SpawnPoint").ChangeStartingItems()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
