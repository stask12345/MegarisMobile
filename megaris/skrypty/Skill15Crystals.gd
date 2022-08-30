extends skill

func _ready():
	lesserSkill = get_node("%Skill14Lesser")
	if bought: applyEffect()
	description = "Crystal Investor+: \n 20% More Crystals"
	costOfSkill = 70

func applyEffect():
	playerStats.crystalBonus += 1

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
