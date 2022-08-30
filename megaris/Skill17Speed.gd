extends skill

func _ready():
	if bought: applyEffect()
	description = "Quick Shooting: \n +10% Attack Speed"
	costOfSkill = 60

func applyEffect():
	playerStats.attackSpeedBonus -= 0.1

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
