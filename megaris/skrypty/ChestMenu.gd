extends Sprite

onready var eq_scripts = get_node("/root/MainScene/CanvasLayer")
var itemInChest

func showChest(itemForChest):
	itemInChest = itemForChest
	$Title.text = itemInChest.title
	if itemInChest is item: $ItemSlot/Potion1.scale = Vector2(0.4,0.4)
	else: $ItemSlot/Potion1.scale = Vector2(0.7,0.7)
	$ItemSlot/Potion1.texture = itemInChest.texture


func _on_LeaveButton_pressed():
	visible = false


func _on_Button_pressed():
	visible = false


func _on_TakeButton_pressed():
	var chest = itemInChest.get_parent()
	itemInChest.visible = true
	eq_scripts.pickUpItem(itemInChest,itemInChest.get_parent(),null)
	itemInChest = null
	if chest.get_child_count() > 2:
		chest.get_child(2).visible = false
	else: 
		chest.emptyChest()
		chest.get_node("ItemTableAnimation/AnimationPlayer").play("idle")
	visible = false
