extends Control

onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var system = get_node("/root/MainScene")

func showWinScreen():
	get_node("/root/MainScene/EffectGenerator").duringBossFight = false
	get_node("/root/MainScene/EffectGenerator").duringRewards = false
	get_node("/root/MainScene/EffectGenerator").duringCastle = false
	get_node("/root/MainScene/EffectGenerator").loadSave = false
	$YouWon/AnimationPlayer.play("idle")
	$Crystals/CrystalCount.text = String(250)
	playerStats.crystals += 250
	system.saveData()
	$KillCount.text += "\n" + String(playerStats.killedMonster) + " Monsters"

func _on_Button_pressed():
	get_tree().quit()


func _on_ButtonReset_pressed():
	get_tree().reload_current_scene()
