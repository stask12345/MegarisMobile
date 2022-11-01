extends skill

onready var effectGenerator = get_node("/root/MainScene/EffectGenerator")
var potion = preload("res://instances/Items/PotionSuper.tscn")

func _ready():
	#if bought: applyEffect() #nie dla reward skilly #na razie
	rewardSkill = true
	description = "Super potion: \nGet devine potion"

func applyEffect():
	effectGenerator.duringRewards = false
	effectGenerator.duringCastle = true
	var p = potion.instance()
	get_node("/root/MainScene/CanvasLayer").putInInventory(p,null,null)
	if p.get_parent():
		return true
	else:
		return false

func buy(): #Reward Skille na razie nie mają ustawianego bought, bo nie ma ich zapisu
	if applyEffect() == true:
		visible = false
		get_node("/root/MainScene/Player/Area2D").invisible = false
		effectGenerator.get_child(0).stop()
		effectGenerator.get_child(0).play("teleportFromHere")
		queue_free() #tylko dla reward skilly
