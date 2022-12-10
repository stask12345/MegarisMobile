extends skill

onready var effectGenerator = get_node("/root/MainScene/EffectGenerator")

func _ready():
	#if bought: applyEffect() #nie dla reward skilly #na razie
	rewardSkill = true
	description = "Super greedy: \nGet 200 gold and 20 crystals"

func applyEffect():
	effectGenerator.duringRewards = false
	effectGenerator.duringCastle = true
	playerStats.gold += 200
	if playerStats.gold > playerStats.maxGoldAcquired: playerStats.maxGoldAcquired = playerStats.gold
	playerStats.crystals += 20

func buy(): #Reward Skille na razie nie mają ustawianego bought, bo nie ma ich zapisu
	visible = false
	applyEffect()
	get_node("/root/MainScene").saveData()
	get_node("/root/MainScene/Player/Area2D").invisible = false
	effectGenerator.get_child(0).stop()
	effectGenerator.get_child(0).play("teleportFromHere")
	effectGenerator.atCastle = "rewardRoom"
	effectGenerator.duringCastle = true
	effectGenerator.getPlayerToCastleEarly()
	queue_free() #tylko dla reward skilly
