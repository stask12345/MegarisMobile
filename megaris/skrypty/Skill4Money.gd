extends skill

func _ready():
	lesserSkill = get_node("%Skill3Lesser")
	if bought: applyEffect()
	description = "Pocket Money+: \n+50 Gold On Start"

func applyEffect():
	playerStats.gold += 20

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
