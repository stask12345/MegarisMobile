extends Sprite

var itemToPick = null
var tableToPickUpFrom = null
onready var eq_scripts = get_parent().get_parent()

func _on_Button_pressed():
	if itemToPick is wepon: 
		eq_scripts.pickUpItem(itemToPick,itemToPick.get_parent(),itemToPick.get_parent().get_parent())
		if itemToPick.get_parent().name != "KinematicBody2D2":
			tableToPickUpFrom.playEffectAnimation()
			if tableToPickUpFrom.name == "startingTable":
				$"../../../Floor/SpawnPoint".swordTaken = true
			get_node("/root/MainScene/MusicPlayer").playTable()
		visible = false
	
	if itemToPick is skill:
		itemToPick.buy()
		if tableToPickUpFrom.get_child(0).get_child(0).visible == false:
			tableToPickUpFrom.playEffectAnimation()
			get_node("/root/MainScene/MusicPlayer").playSkill()
			$Label2.text = ""
		visible = false
