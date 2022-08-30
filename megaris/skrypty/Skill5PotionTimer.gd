extends skill

func _ready():
	if bought: applyEffect()
	description = "Improved Potions: \n+2s Potion Duraction"
	costOfSkill = 30

func applyEffect():
	playerStats.potionDuration += 2

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
