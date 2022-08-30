extends skill

func _ready():
	lesserSkill = get_node("%Skill8Lesser")
	if bought: applyEffect()
	description = "Rich Monsters+: \nMonsters Drops More Gold"
	costOfSkill = 200

func applyEffect():
	playerStats.bonusCoins += 1

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
