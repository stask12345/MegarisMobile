extends Node

var labelToGenerate = preload("res://instances/damageLabel.tscn")
var atCastle = ""
var tutorialComplete = false
var duringBossFight = false
var duringRewards = false
var duringCastle = false
var loadSave = false
var loadedData = false
onready var canvasModulator = get_node("/root/MainScene/CanvasModulate")
onready var cameraShakingAnimation = get_node("/root/MainScene/Player/AnimationPlayerCamera")
onready var player = get_node("/root/MainScene/Player")
onready var UI = get_node("/root/MainScene/CanvasLayer/Control5")
onready var UI1 = get_node("/root/MainScene/CanvasLayer/Control3")
onready var UI2 = get_node("/root/MainScene/CanvasLayer/Control2")
onready var UI3 = get_node("/root/MainScene/CanvasLayer/Control")
onready var UI4 = get_node("/root/MainScene/CanvasLayer/Control4")
onready var UIBoss = get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/BossMenu")
var whiteGraphic = preload("res://grafika/transparent.png")

func _ready():
	if tutorialComplete:
		atCastle = "mine"
		$AnimationPlayer.play("startingAnimation")
		if loadSave:
			$AnimationPlayer.advance(7)
		if !loadSave:
			duringBossFight = false
			duringRewards = false
		loadSave = true
	else:
		var tutorial = preload("res://instances/Tutorial.tscn").instance()
		get_node("/root/MainScene").call_deferred("add_child",tutorial)
		get_node("/root/MainScene/Player").global_position = Vector2(-2455,1996)
		$AnimationPlayer.play("startingAnimationTutorial")

func generateDamageLabel(positionOfDamage, value, playerBool = false):
	var damageLabel = labelToGenerate.instance()
	damageLabel.get_child(0).text = String(value)
	damageLabel.get_child(0).rect_global_position = positionOfDamage
	damageLabel.get_child(0).self_modulate = Color(1,0.1,0.1)
	if playerBool: damageLabel.get_child(0).self_modulate = Color(1,0.5,0.5)
	add_child(damageLabel)

func deathAnimation():
	player.trapped = true
	player.alive = false
	UI.visible = false
	UI1.visible = false
	UI2.visible = false
	UI3.visible = false
	UI4.visible = false
	UIBoss.visible = false
	
	player.get_node("WeponHolder").visible = false
	player.get_node("AnimationPlayer").play("idle_right")
	player.get_node("DeathExplosion/AnimationPlayer").play("deathExplosion")
	player.get_node("Area2D").monitoring = false
	canvasModulator.color = Color(0.1,0.1,0.1)
	get_node("/root/MainScene/MusicPlayer").playRumble()
	get_node("/root/MainScene/MusicPlayer").playDefeatTheme()
	if player.get_node("Light2D").energy == 1: player.get_node("AnimationPlayerLight").play("deathLighting")
	else: player.get_node("AnimationPlayerLight").play("deathLightingCastle")
	cameraShakingAnimation.play("cameraShaking")

func makePlayerInvisible():
	player.playerVisible = false

func playStartingAnimation():
	$AnimationPlayer.play("startingAnimation")

func makePlayerIndestructable():
	player.get_node("Area2D").invisible = true
	player.trapped = true

func putGrave():
	var grave = preload("res://instances/Grave.tscn").instance()
	player.modulate = Color(1,1,1)
	player.get_node("Player").visible = false
	player.get_node("PlayerCliming").visible = false
	grave.position = Vector2(0,-15)
	player.add_child(grave)

func spawnPlayer():
	player.trapped = false
	player.stuck = false
	player.playerVisible = true
	player.get_node("Area2D").invisible = false

func getPlayerToRewardRoom():
	atCastle = ""
	var rewardRoom = load("res://instances/RewardRoom.tscn").instance()
	get_node("/root/MainScene").add_child(rewardRoom) #Dla 
	player.global_position = Vector2(0,2100)
	get_node("/root/MainScene/EffectGenerator/Monster-Boss").queue_free()

func getPlayerToRewardRoomLoad():#Przy wczytywaniu
	get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/StageNameRotation/StageName/AnimationPlayer").stop()
	atCastle = ""
	var rewardRoom = load("res://instances/RewardRoom.tscn").instance()
	get_node("/root/MainScene").call_deferred("add_child",rewardRoom) #Dla 
	get_node("/root/MainScene/Player").global_position = Vector2(0,2100)

func getPlayerToCastle():
	atCastle = "castle"
	var rewardRoom = get_node("/root/MainScene/RewardRoom")
	get_node("/root/MainScene/GeneratedTerrain").queue_free()
	get_node("/root/MainScene/Terrain").queue_free()
	if get_node("/root/MainScene/Floor/ItemMarket").bought: get_node("/root/MainScene/Floor/ItemMarket/Market").clearTables()
	var castle = load("res://instances/Castle.tscn").instance()
	var monsters = get_children()
	for m in monsters:
		if m.name != "AnimationPlayer":
			m.queue_free()
	get_node("/root/MainScene").add_child(castle)
	player.global_position = Vector2(-120,906)
	rewardRoom.queue_free()
	get_node("/root/MainScene/MusicPlayer").playDeflautTheme()
	duringCastle = true

func getPlayerToCastleLoad():
	atCastle = "castle"
	get_node("/root/MainScene/GeneratedTerrain").queue_free()
	get_node("/root/MainScene/Terrain").queue_free()
	if get_node("/root/MainScene/Floor/ItemMarket").bought: get_node("/root/MainScene/Floor/ItemMarket/Market").clearTables()
	var castle = load("res://instances/Castle.tscn").instance()
	get_node("/root/MainScene").call_deferred("add_child",castle)
	duringCastle = true

func getPlayerToStartingPoint():
	atCastle = "mine"
	var tutorialRoom = get_node("/root/MainScene/Tutorial")
	var monsters = get_children()
	player.global_position = Vector2(-120,906)
	tutorialRoom.queue_free()
	tutorialComplete = true
	get_node("/root/MainScene/CanvasLayer/Control4/WeponHolder").remove_child(get_node("/root/MainScene/CanvasLayer/Control4/WeponHolder").get_child(0))
	get_node("/root/MainScene/Player/WeponHolder/swordRotation/spriteOfWepon").texture = whiteGraphic
	get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/StageNameRotation/StageName/AnimationPlayer").play("mine")
	loadSave = true
	get_node("/root/MainScene").saveData()

func enterBossArea():
	get_node("/root/MainScene/Terrain/Elements/BossRoom/Area2D").queue_free()
	player.trapped = true
	player.stuck = true
	$AnimationPlayer.play("bossAnimation")
	var slimeToKill = get_node("/root/MainScene/Terrain/Elements/BossRoom/Monster-Slime")
	if player.global_position.x - slimeToKill.global_position.x > 0:
		player.get_node("Player").scale.x = -1
	else: player.get_node("Player").scale.x = 1
	duringBossFight = true
	get_node("/root/MainScene").saveData()

func enterBossAreaCastle():
	get_node("/root/MainScene/Castle/Terrain/BossRoom/Area2DBoss").queue_free()
	player.trapped = true
	player.stuck = true
	$AnimationPlayer.play("bossAnimationCastle")
	var bossPoint = get_node("/root/MainScene/Castle/Terrain/BossRoom/Boss-room-trone")
	if player.global_position.x - bossPoint.global_position.x > 0:
		player.get_node("Player").scale.x = -1
	else: player.get_node("Player").scale.x = 1
	duringBossFight = true
	get_node("/root/MainScene").saveData()

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		enterBossArea()

func spawBoss():
	var boss1 = preload("res://instances/Monsters/Monster-Boss1.tscn").instance()
	boss1.position = Vector2(0,-3600)
	add_child(boss1)

func spawBossCastle():
	changeBossLabelCastle()
	get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/BossMenu/Boss-bar").visible = true
	get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/BossMenu/Boss-hp").visible = true
	var boss2 = preload("res://instances/Monsters/Monster-Boss2.tscn").instance()
	boss2.position = Vector2(0,-3450)
	add_child(boss2)

func changeBossLabel():
	duringBossFight = false
	duringRewards = true
	UIBoss.get_child(2).text = " Boss defeated!"

func changeBossLabelCastle():
	UIBoss.get_child(2).text = " Fallen Emperor"

func killSlimeOnBossFight():
	var slimeToKill = get_node("/root/MainScene/Terrain/Elements/BossRoom/Monster-Slime")
	slimeToKill.minCoins = -2
	slimeToKill.maxCoins = -1
	slimeToKill.playAnimationAndDestroy()

func playTitleAnimation():
	if !duringRewards:
		if duringCastle: atCastle = "castle"
		if atCastle == "mine":
			get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/StageNameRotation/StageName/AnimationPlayer").play("mine")
		if atCastle == "castle":
			get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/StageNameRotation/StageName/AnimationPlayer").play("castle")

func save():
	var node_data = {
		"loadSave": loadSave,
		"tutorialComplete": tutorialComplete,
		"duringBossFight": duringBossFight,
		"duringRewards": duringRewards,
		"duringCastle": duringCastle,
		"nodePath": get_path()
	}
	return node_data

func finalBossDefeted():
	$AnimationPlayer.play("finalBossDefeted")

func playerOnLadder():
	player.position = Vector2(0,-4160)
	get_node("/root/MainScene/CanvasLayer").makeUIInVisible()
	player.get_node("WeponHolder").visible = false

func playerRemoteControl(vec):
	get_node("/root/MainScene/CanvasLayer/Control/Joystick/TouchScreenButton").remoteControlVector = vec
	get_node("/root/MainScene/CanvasLayer/Control/Joystick/TouchScreenButton").remoteControl = true
	get_node("/root/MainScene/CanvasLayer/Control/Joystick/TouchScreenButton").remoteControl = true

func turnPlayerAround():
	player.onLadder = true

func playWinAnimation():
	get_node("/root/MainScene/CanvasLayer/Control-WinScreen/AnimationPlayer").play("showWinScreen")

