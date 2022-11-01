extends skill

func _ready():
	lesserSkill = get_node("%Skill17")
	if bought: applyEffect()
	description = "Quick Shooting+: \n +20% Attack Speed"
	costOfSkill = 125

func applyEffect():
	playerStats.attackSpeedBonus -= 0.1

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
