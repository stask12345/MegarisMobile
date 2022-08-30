extends skill

func _ready():
	if bought: applyEffect()
	description = "Defense Technique: \n+2 Defence"
	costOfSkill = 40

func applyEffect():
	playerStats.armorIncrease += 2

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
