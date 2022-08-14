extends skill

func _ready():
	lesserSkill = get_node("%Skill17")
	if bought: applyEffect()
	description = "Quick Shooting II: \n +20% Attack Speed"

func applyEffect():
	playerStats.attackSpeedBonus -= 0.1

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
