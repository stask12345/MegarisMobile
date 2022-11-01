extends skill

func _ready():
	if bought: applyEffect()
	description = "Boss Slayer: \n +20% More Damage To Boss Monsters"
	costOfSkill = 40

func applyEffect():
	playerStats.bossSlayerBonus = 1.2

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
