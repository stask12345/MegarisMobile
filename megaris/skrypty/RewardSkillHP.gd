extends skill

onready var effectGenerator = get_node("/root/MainScene/EffectGenerator")

func _ready():
	#if bought: applyEffect() #nie dla reward skilly #na razie
	rewardSkill = true
	description = "Super Vitality: \n+50 Max Health "

func applyEffect():
	effectGenerator.duringRewards = false
	effectGenerator.duringCastle = true
	playerStatsHp.maxHp += 50
	playerStatsHp.hp += 50

func buy(): #Reward Skille na razie nie mają ustawianego bought, bo nie ma ich zapisu
	visible = false
	applyEffect()
	get_node("/root/MainScene/Player/Area2D").invisible = false
	effectGenerator.get_child(0).stop()
	effectGenerator.get_child(0).play("teleportFromHere")
	effectGenerator.atCastle = "rewardRoom"
	effectGenerator.duringCastle = true
	effectGenerator.getPlayerToCastleEarly()
	queue_free() #tylko dla reward skilly
