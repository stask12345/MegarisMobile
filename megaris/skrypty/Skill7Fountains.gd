extends skill

func _ready():
	if bought: applyEffect()
	description = "Water Blessing: \nMore Fountains"
	costOfSkill = 75

func applyEffect():
	playerStats.spawnMoreFountains += 1

func buy():
	applyEffect()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
