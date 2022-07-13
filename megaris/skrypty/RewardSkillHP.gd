extends skill


func _ready():
	#if bought: applyEffect() #nie dla reward skilly #na razie
	rewardSkill = true
	description = "Super Vitality: +50 Max Health"

func applyEffect():
	playerStatsHp.maxHp += 50
	playerStatsHp.hp += 50

func buy(): #Reward Skille na razie nie mają ustawianego bought, bo nie ma ich zapisu
	visible = false
	applyEffect()
	queue_free() #tylko dla reward skilly
