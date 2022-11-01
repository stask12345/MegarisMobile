extends skill

func _ready():
	if bought: applyEffect()
	description = "Accuracy Improvement: \nBullets rangne increase"
	costOfSkill = 60

func applyEffect():
	playerStats.bulletRangeImprovement = 1.2

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
