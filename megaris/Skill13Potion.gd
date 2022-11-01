extends skill

func _ready():
	lesserSkill = get_node("%Skill12Lesser")
	if bought: applyEffect()
	description = "Alchemist+: \n Healing Potion III On Start"
	costOfSkill = 50

func applyEffect():
	playerStats.levelOfItem += 2

func buy():
	applyEffect()
	get_node("/root/MainScene/Floor/SpawnPoint").ChangeStartingItems()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
