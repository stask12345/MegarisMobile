extends skill

func _ready():
	if bought: applyEffect()
	description = "Rich Monsters I: \nMonsters Drops More Gold"

func applyEffect():
	playerStats.bonusCoins += 1

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
