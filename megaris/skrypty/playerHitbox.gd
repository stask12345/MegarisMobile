extends Area2D

onready var hpScript = get_parent().get_parent().get_node("CanvasLayer/Control3/Hp")
onready var player = get_parent()
onready var effectGenerator = get_node("/root/MainScene/EffectGenerator")
onready var deathScreen = get_node("/root/MainScene/CanvasLayer/Control-DeathScreen")
var invisible = false

func _on_Area2D_area_entered(area):
	var monster = area.get_parent()
	if "monster" in area.name and !player.hpDelay and !invisible and monster.name != "Dummy" and (!monster is monsterClass or !monster.destroyed):
		player.hpDelay = true
		player.hpDelayTimer()
		if (!monster is monsterClass or (monster is monsterClass and !monster.destroyed)): hpScript.dealDamagePlayer(monster.attackStrenght)
		if (monster is monsterClass and !monster.destroyed) or (!monster is monsterClass and monster.shootingMonster != null): player.get_knock(monster.goingRight)
		if "Boss" in area.get_parent().name and (monster is monsterClass and !monster.destroyed): player.get_knock(monster.goingRight,true)
		deathScreen.changeKillerMonster(monster)
		exitShopAndAnvil()
		get_node("/root/MainScene/Player/SoundEffectOuch").play()
		if monster is monsterClass and monster.flying: #zatrzymywanie latających po ataku
			monster.stayInPlace()

func exitShopAndAnvil():
	#get_node("/root/MainScene/CanvasLayer/Control4/ShopMenu").returnItemsToShopObject()
	get_node("/root/MainScene/CanvasLayer/Control4/ShopMenu").visible = false
	get_node("/root/MainScene/CanvasLayer/Control4/AnvilMenu").visible = false
	get_node("/root/MainScene/CanvasLayer/Control4/GameMenu").visible = false
