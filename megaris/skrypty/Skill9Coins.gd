extends skill

func _ready():
	lesserSkill = get_node("%Skill8Lesser")
	if bought: applyEffect()
	description = "Rich Monsters II: \nMonsters Drops Even"

func applyEffect():
	playerStats.bonusCoins += 2

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
