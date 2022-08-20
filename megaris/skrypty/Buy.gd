extends Sprite

onready var eq_scripts = get_node("/root/MainScene/CanvasLayer")
onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
var tableToPickUpFrom = null
var objectToBuy

func _on_Button_pressed():
	if objectToBuy is wepon or objectToBuy is item:
		if objectToBuy.costOfSkill <= playerStats.crystals:
			var table = objectToBuy.get_parent()
			eq_scripts.pickUpItem(objectToBuy,objectToBuy.get_parent(),null)
			get_node("/root/MainScene/Floor/ItemMarket/Market").makeTablesEmpty()
			if table.get_child_count() == 0:
				playerStats.crystals -= objectToBuy.costOfSkill
				tableToPickUpFrom.playEffectAnimation()
	else: 
		objectToBuy.buy()
		if tableToPickUpFrom != null: tableToPickUpFrom.playEffectAnimation()
	visible = false
