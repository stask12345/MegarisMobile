extends Sprite

onready var enterButton = get_node("/root/MainScene/CanvasLayer/Control4/Enter")
onready var shopMenu = get_node("/root/MainScene/CanvasLayer/Control4/ShopMenu")
onready var weponHolder = get_node("/root/MainScene/CanvasLayer/Control4/WeponHolder")
onready var shopSlot1 = get_node("/root/MainScene/CanvasLayer/Control4/ShopMenu/ShopSlot1")
onready var shopSlot2 = get_node("/root/MainScene/CanvasLayer/Control4/ShopMenu/ShopSlot2")
onready var shopSlot3 = get_node("/root/MainScene/CanvasLayer/Control4/ShopMenu/ShopSlot3")

func _on_Area2D_body_entered(body):
	if body.name == "Player" and weponHolder.get_child_count() > 0:
		if $ItemSlot1.get_child_count() > 0 and $ItemSlot1.get_child(0):
			var itemInSlot = $ItemSlot1.get_child(0)
			itemInSlot.get_parent().remove_child(itemInSlot)
			shopSlot1.add_child(itemInSlot)
		
		if $ItemSlot2.get_child_count() > 0 and $ItemSlot2.get_child(0):
			var itemInSlot = $ItemSlot2.get_child(0)
			itemInSlot.get_parent().remove_child(itemInSlot)
			shopSlot2.add_child(itemInSlot)
		
		if $ItemSlot3.get_child_count() > 0 and $ItemSlot3.get_child(0):
			var itemInSlot = $ItemSlot3.get_child(0)
			itemInSlot.get_parent().remove_child(itemInSlot)
			shopSlot3.add_child(itemInSlot)
		
		shopMenu.currentShop = self
		shopMenu.showShop()
		enterButton.visible = true
		var animationPlayer = enterButton.get_child(0)
		enterButton.menuToEnter = shopMenu
		animationPlayer.play("pick_up_sight_animation")


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		shopMenu.returnItemsToShopObject()
		enterButton.visible = false
		enterButton.get_child(0).stop()
		shopMenu.visible = false
