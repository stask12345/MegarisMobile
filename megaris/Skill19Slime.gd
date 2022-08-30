extends skill

func _ready():
	if bought: applyEffect()
	description = "Slime Slayer: \n +10% Damage Against Slimes"
	costOfSkill = 20

func applyEffect():
	playerStats.slimeAttackBonus += 0.2

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
