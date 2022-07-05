extends Sprite

var itemToPick = null
onready var eq_scripts = get_parent().get_parent()

func _on_Button_pressed():
	if itemToPick: 
		eq_scripts.pickUpItem(itemToPick,itemToPick.get_parent(),itemToPick.get_parent().get_parent())
		visible = false
