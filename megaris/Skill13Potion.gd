extends skill

func _ready():
	lesserSkill = get_node("%Skill12Lesser")
	if bought: applyEffect()
	description = "Better Potions+: \n Healing Potion III On Start"

func applyEffect():
	playerStats.levelOfItem += 2

func buy():
	applyEffect()
	get_node("/root/MainScene/Floor/SpawnPoint").ChangeStartingItems()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
