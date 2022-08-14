extends skill

func _ready():
	if bought: applyEffect()
	description = "Better Wepon: \nSteel Sword On Start"

func applyEffect():
	playerStats.levelOfWepon += 1

func buy():
	applyEffect()
	get_node("/root/MainScene/Floor/SpawnPoint").ChangeStartingItems()
	bought = true
	visible = false
	get_node("/root/MainScene/Floor/SkillMarket/Market").makeTablesEmpty()
