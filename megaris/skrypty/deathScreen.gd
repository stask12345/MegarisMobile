extends Control

var monsterKiller
onready var player = get_node("/root/MainScene/Player")
onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var system = get_node("/root/MainScene")

func changeKillerMonster(monster):
	if monsterKiller: monsterKiller.queue_free()
	if monster is monsterClass: monsterKiller = monster.duplicate()
	else: monsterKiller = monster.shootingMonster.duplicate()

func showDeathScreen():
	visible = true
	var monster = monsterKiller
	monster.position = Vector2(0,0)
	monster.gravity = 0
	monster.maxGravity = 0
	monster.get_node("monsterBody").monitorable = false
	monster.get_node("monsterBody").monitoring = false
	monster.destroyed = true
	monster.scale = Vector2(3,3)
	if monster.get_node("Monster1").texture.get_height() >= 200: monster.scale = Vector2(1,1)
	$Monster.add_child(monster)
	$MonsterName.text = monster.monsterName
	$Reach.text += "\n" + String(abs(round((player.position.y - 805)/320))) + "th Floor"
	$Crystals/CrystalCount.text = String(playerStats.totalCollected / (10 - playerStats.crystalBonus))
	playerStats.crystals += (playerStats.totalCollected / (10 - playerStats.crystalBonus))
	system.saveData()
	$KillCount.text += "\n" + String(playerStats.killedMonster) + " Monsters"
	$AnimationPlayer.play("deathAnimation")


func _on_Button_pressed():
	get_tree().quit()


func _on_ButtonReset_pressed():
	get_tree().reload_current_scene()
