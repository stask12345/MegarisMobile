extends Node

var labelToGenerate = preload("res://instances/damageLabel.tscn")
onready var canvasModulator = get_node("/root/MainScene/CanvasModulate")
onready var cameraShakingAnimation = get_node("/root/MainScene/Player/AnimationPlayerCamera")
onready var player = get_node("/root/MainScene/Player")
onready var UI = get_node("/root/MainScene/CanvasLayer/Control5")
onready var UI1 = get_node("/root/MainScene/CanvasLayer/Control3")
onready var UI2 = get_node("/root/MainScene/CanvasLayer/Control2")
onready var UI3 = get_node("/root/MainScene/CanvasLayer/Control")
onready var UI4 = get_node("/root/MainScene/CanvasLayer/Control4")
onready var UIBoss = get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/BossMenu")

func generateDamageLabel(positionOfDamage, value, player = false):
	var damageLabel = labelToGenerate.instance()
	damageLabel.get_child(0).text = String(value)
	damageLabel.get_child(0).rect_global_position = positionOfDamage
	damageLabel.get_child(0).self_modulate = Color(1,0.1,0.1)
	if player: damageLabel.get_child(0).self_modulate = Color(1,0.5,0.5)
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
	player.get_node("AnimationPlayerLight").play("deathLighting")
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

func getPlayerToRewardRoom():
	var rewardRoom = load("res://instances/RewardRoom.tscn").instance()
	get_node("/root/MainScene").add_child(rewardRoom)
	player.global_position = Vector2(0,2100);

func getPlayerToCastle():
	var rewardRoom = get_node("/root/MainScene/RewardRoom")
	get_node("/root/MainScene/GeneratedTerrain").queue_free()
	get_node("/root/MainScene/Terrain").queue_free()
	var castle = load("res://instances/Castle.tscn").instance()
	var monsters = get_children()
	for m in monsters:
		if m.name != "AnimationPlayer":
			m.queue_free()
	get_node("/root/MainScene").add_child(castle)
	player.global_position = Vector2(-120,906)
	rewardRoom.queue_free()

func enterBossArea():
	get_node("/root/MainScene/Terrain/Elements/BossRoom/Area2D").queue_free()
	player.trapped = true
	player.stuck = true
	$AnimationPlayer.play("bossAnimation")
	var slimeToKill = get_node("/root/MainScene/Terrain/Elements/BossRoom/Monster-Slime")
	if player.global_position.x - slimeToKill.global_position.x > 0:
		player.get_node("Player").scale.x = -1
	else: player.get_node("Player").scale.x = 1

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		enterBossArea()

func spawBoss():
	var boss1 = preload("res://instances/Monsters/Monster-Boss1.tscn").instance()
	boss1.position = Vector2(0,-3600)
	add_child(boss1)

func changeBossLabel():
	UIBoss.get_child(2).text = " Boss defeated!"

func killSlimeOnBossFight():
	var slimeToKill = get_node("/root/MainScene/Terrain/Elements/BossRoom/Monster-Slime")
	slimeToKill.minCoins = -2
	slimeToKill.maxCoins = -1
	slimeToKill.playAnimationAndDestroy()
