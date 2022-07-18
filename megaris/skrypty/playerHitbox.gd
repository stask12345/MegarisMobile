extends Area2D

onready var hpScript = get_parent().get_parent().get_node("CanvasLayer/Control3/Hp")
onready var player = get_parent()
onready var effectGenerator = get_node("/root/MainScene/EffectGenerator")
onready var deathScreen = get_node("/root/MainScene/CanvasLayer/Control-DeathScreen")
var invisible = false

func _on_Area2D_area_entered(area):
	var monster = area.get_parent()
	if "monster" in area.name and !player.hpDelay and !invisible:
		print("weszlo")
		player.hpDelay = true
		player.hpDelayTimer()
		if (!monster is monsterClass or (monster is monsterClass and !monster.destroyed)): hpScript.dealDamagePlayer(monster.attackStrenght)
		player.get_knock(monster.goingRight)
		deathScreen.changeKillerMonster(monster)
		if monster is monsterClass and monster.flying: #zatrzymywanie latających po ataku
			monster.stayInPlace()
