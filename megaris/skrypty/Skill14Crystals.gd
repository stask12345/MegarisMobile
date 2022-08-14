extends skill

func _ready():
	if bought: applyEffect()
	description = "Crystal Investor I: \n 10% More Crystals"

func applyEffect():
	playerStats.crystalBonus += 1

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
