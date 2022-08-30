extends skill

func _ready():
	if bought: applyEffect()
	description = "Rich Monsters: \nMonsters Drops More Gold"
	costOfSkill = 60

func applyEffect():
	playerStats.bonusCoins += 1

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
