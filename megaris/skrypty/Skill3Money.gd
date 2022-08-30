extends skill

func _ready():
	if bought: applyEffect()
	description = "Pocket Money: \n+30 Gold On Start"
	costOfSkill = 40

func applyEffect():
	playerStats.gold += 30

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
