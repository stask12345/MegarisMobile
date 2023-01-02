extends Control

var addedCash = 0 #Dla pokazywania statystyk
var gold = 0
var crystals = 0
var levelOfArmor = 0
var armorIncrease = 0
var strengthIncrease = 1 #Attack multiplayer
var maxDamageIncrease = 0
var killedMonster = 0
var potionDuration = 0
var spawnMoreFountains = 0
var bonusCoins = 0
var bulletRangeImprovement = 0
var totalCollected : int = 0
var levelOfWepon = 0
var levelOfItem = 0
var crystalBonus = 0
var bossSlayerBonus = 1
var attackSpeedBonus = 1
var slimeAttackBonus = 1
var slimesSlayed = 0
var skeletonsSlayed = 0
var slayedFirstBoss = 0
var slayedSecondBoss = 0
var maxHpAcquired = 0
var maxGoldAcquired = 0
var addHpWatched = false
var playerAnimationWalking1 = preload("res://grafika/animation/player_animation1.png")
var playerAnimationWalking2 = preload("res://grafika/animation/player_animation2.png")
var playerAnimationWalking3 = preload("res://grafika/animation/player_animation3.png")
var playerAnimationWalking4 = preload("res://grafika/animation/player_animation4.png")
var playerAnimationWalking5 = preload("res://grafika/animation/player_animation5.png")
var playerAnimationCliming1 = preload("res://grafika/animation/player_climing_animation1.png")
var playerAnimationCliming2 = preload("res://grafika/animation/player_climing_animation2.png")
var playerAnimationCliming3 = preload("res://grafika/animation/player_climing_animation3.png")
var playerAnimationCliming4 = preload("res://grafika/animation/player_climing_animation4.png")
var playerAnimationCliming5 = preload("res://grafika/animation/player_climing_animation5.png")
onready var player = get_node("/root/MainScene/Player")

func _process(_delta):
#	if Input.is_key_pressed(16777351):
#		get_node("/root/MainScene/EffectGenerator/AnimationPlayer").play("teleportToCastle")
	if Input.is_key_pressed(16777229):
		get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
	if Input.is_key_pressed(KEY_P):
		player.position = Vector2(-1040,-3279)
	if Input.is_key_pressed(KEY_O):
		player.position = Vector2(-1040,-4500)
	$Crystals.text = String(crystals)
	$Gold.text = String(gold)

func updatePlayerLook():
	if levelOfArmor == 1:
		player.get_node("Player").texture = playerAnimationWalking1
		player.get_node("PlayerCliming").texture = playerAnimationCliming1
	if levelOfArmor == 2:
		player.get_node("Player").texture = playerAnimationWalking2
		player.get_node("PlayerCliming").texture = playerAnimationCliming2
	if levelOfArmor == 3:
		player.get_node("Player").texture = playerAnimationWalking3
		player.get_node("PlayerCliming").texture = playerAnimationCliming3
	if levelOfArmor == 4:
		player.get_node("Player").texture = playerAnimationWalking4
		player.get_node("PlayerCliming").texture = playerAnimationCliming4
	if levelOfArmor == 5:
		player.get_node("Player").texture = playerAnimationWalking5
		player.get_node("PlayerCliming").texture = playerAnimationCliming5

func make_invisible(InvisibleTime):
	InvisibleTime += potionDuration
	player.get_node("Player").self_modulate.a = 0.4
	player.get_node("PlayerCliming").self_modulate.a = 0.4
	player.get_node("Area2D").invisible = true
	yield(get_tree().create_timer(InvisibleTime),"timeout")
	player.get_node("Player").self_modulate.a = 1
	player.get_node("PlayerCliming").self_modulate.a = 1
	player.get_node("Area2D").invisible = false

func make_stronger(strongerTime):
	player.get_node("HighLight/AnimationPlayer").play("idle_highlight")
	strongerTime += potionDuration
	player.get_node("HighLight").visible = true
	strengthIncrease = 2
	yield(get_tree().create_timer(strongerTime),"timeout")
	player.get_node("HighLight").visible = false
	strengthIncrease = 1
	player.get_node("HighLight/AnimationPlayer").stop()

func save():
	var node_data = {
		"crystals": crystals,
		"slimesSlayed": slimesSlayed,
		"skeletonsSlayed": skeletonsSlayed,
		"slayedFirstBoss": slayedFirstBoss,
		"slayedSecondBoss": slayedSecondBoss,
		"maxHpAcquired": maxHpAcquired,
		"maxGoldAcquired": maxGoldAcquired,
	#	"addedCash": addedCash,
		"nodePath": get_path()
	}
	return node_data

func saveCurrent():
	var node_data = {
		"type": "normal",
		"gold": gold,
		"totalCollected": totalCollected,
		"levelOfArmor": levelOfArmor,
		"killedMonster": killedMonster,
		"addHpWatched": addHpWatched,
		"nodePath": get_path()
	}
	return node_data
