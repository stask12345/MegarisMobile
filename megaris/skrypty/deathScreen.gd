extends Control

var monsterKiller
onready var player = get_node("/root/MainScene/Player")
onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var system = get_node("/root/MainScene")

func changeKillerMonster(monster):
	if monsterKiller: monsterKiller.queue_free()
	if monster is monsterClass or monster is trap: 
		monsterKiller = monster.duplicate()
		if !monster is trap and monster.bossMinion: monsterKiller = preload("res://instances/Monsters/Monster-Boss2.tscn").instance()
	else:
		if monster.shootingMonster:
			monsterKiller = monster.shootingMonster.duplicate()
			if monster.shootingMonster.bossMinion: preload("res://instances/Monsters/Monster-Boss2.tscn").instance()
		else: monsterKiller = preload("res://instances/Monsters/Monster-Boss2.tscn").instance()

func showDeathScreen():
	get_node("/root/MainScene/EffectGenerator").duringBossFight = false
	get_node("/root/MainScene/EffectGenerator").duringRewards = false
	get_node("/root/MainScene/EffectGenerator").duringCastle = false
	visible = true
	var monster = monsterKiller
	if monster is monsterClass:
		monster.position = Vector2(0,0)
		monster.gravity = 0
		monster.maxGravity = 0
		monster.get_node("monsterBody").monitorable = false
		monster.get_node("monsterBody").monitoring = false
		monster.destroyed = true
		monster.scale = Vector2(3,3)
		monster.modulate = Color.white
		if monster.get_node("Monster1").texture.get_height() >= 80: monster.scale = Vector2(2,2)
		if monster.get_node("Monster1").texture.get_height() >= 200: #Boss
			monster.scale = Vector2(1,1)
	if monster is trap:
		monster.get_child(0).get_child(0).disabled = true
		monster.scale = Vector2(3,3)
		monster.position = Vector2(12,0)
	$Monster.add_child(monster)
	$MonsterName.text = monster.monsterName
	$Reach.text += "\n" + String(abs(round((player.position.y - 805)/320))) + "th Floor"
	$Crystals/CrystalCount.text = String(playerStats.totalCollected / (10 - playerStats.crystalBonus))
	playerStats.crystals += (playerStats.totalCollected / (10 - playerStats.crystalBonus))
	get_node("/root/MainScene/EffectGenerator").loadSave = false
	system.saveData()
	$KillCount.text += "\n" + String(playerStats.killedMonster) + " Monsters"
	$AnimationPlayer.play("deathAnimation")


func _on_Button_pressed():
	get_tree().quit()


func _on_ButtonReset_pressed():
	get_tree().reload_current_scene()
