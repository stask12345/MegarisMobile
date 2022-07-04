extends Sprite

onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var eq_scripts = get_node("/root/MainScene/CanvasLayer")
var currentShop

func showShop(): #Skaluje wielkość broni i itenów by dobrze wyglądały / potem odskaluje przy kupnie
	if $ShopSlot1.get_child_count() > 0:
		$Item1Slod.visible = false
		$Item1Price.visible = true
		$Item1Label.visible = true
		$BuyItem1.visible = true
		var item1 = $ShopSlot1.get_child(0)
		if item1 is wepon:
			item1.scale = Vector2(0.7,0.7)
		if item1 is item:
			item1.scale = Vector2(0.4,0.4)
		$Item1Label.text = item1.title
		$Item1Price.text = String(item1.price) + " Gold"
	
	if $ShopSlot1.get_child_count() == 0:
		$Item1Slod.visible = true
		$Item1Price.visible = false
		$Item1Label.visible = false
		$BuyItem1.visible = false
	
	if $ShopSlot2.get_child_count() > 0:
		$Item2Slod.visible = false
		$Item2Price.visible = true
		$Item2Label.visible = true
		$BuyItem2.visible = true
		var item2 = $ShopSlot2.get_child(0)
		if item2 is wepon:
			item2.scale = Vector2(0.7,0.7)
		if item2 is item:
			item2.scale = Vector2(0.4,0.4)
		$Item2Label.text = item2.title
		$Item2Price.text = String(item2.price) + " Gold"
	
	if $ShopSlot2.get_child_count() == 0:
		$Item2Slod.visible = true
		$Item2Price.visible = false
		$Item2Label.visible = false
		$BuyItem2.visible = false
	
	if $ShopSlot3.get_child_count() > 0:
		$Item3Slod.visible = false
		$Item3Price.visible = true
		$Item3Label.visible = true
		$BuyItem3.visible = true
		var item3 = $ShopSlot3.get_child(0)
		if item3 is wepon:
			item3.scale = Vector2(0.7,0.7)
		if item3 is item:
			item3.scale = Vector2(0.4,0.4)
		$Item3Label.text = item3.title
		$Item3Price.text = String(item3.price) + " Gold"
	
	if $ShopSlot3.get_child_count() == 0:
		$Item3Slod.visible = true
		$Item3Price.visible = false
		$Item3Label.visible = false
		$BuyItem3.visible = false


func _on_Button_pressed():
	visible = false
	returnItemsToShopObject()

func returnItemsToShopObject():
	if $ShopSlot1.get_child(0): 
		var itemInSlot = $ShopSlot1.get_child(0)
		itemInSlot.get_parent().remove_child(itemInSlot)
		currentShop.get_node("ItemSlot1").add_child(itemInSlot)
	
	if $ShopSlot2.get_child(0): 
		var itemInSlot = $ShopSlot2.get_child(0)
		itemInSlot.get_parent().remove_child(itemInSlot)
		currentShop.get_node("ItemSlot2").add_child(itemInSlot)
	
	if $ShopSlot3.get_child(0): 
		var itemInSlot = $ShopSlot3.get_child(0)
		itemInSlot.get_parent().remove_child(itemInSlot)
		currentShop.get_node("ItemSlot3").add_child(itemInSlot)
	

func _on_BuyItem1Button_pressed():
	if $ShopSlot1.get_child_count() > 0 and playerStats.gold >= $ShopSlot1.get_child(0).price:
		var item1 = $ShopSlot1.get_child(0)
		if item1 is wepon: item1.scale = Vector2(1,1)
		if item1 is item: item1.scale = Vector2(0.5,0.5)
		
		var price = item1.price
		eq_scripts.pickUpItem(item1,$ShopSlot1,null)
		if $ShopSlot1.get_child_count() == 0: playerStats.gold -= price
		showShop()


func _on_BuyItem2Button_pressed():
	if $ShopSlot2.get_child_count() > 0 and playerStats.gold >= $ShopSlot2.get_child(0).price:
		var item2 = $ShopSlot2.get_child(0)
		if item2 is wepon: item2.scale = Vector2(1,1)
		if item2 is item: item2.scale = Vector2(0.5,0.5)
		
		var price = item2.price
		eq_scripts.pickUpItem(item2,$ShopSlot2,null)
		if $ShopSlot2.get_child_count() == 0: playerStats.gold -= price
		showShop()


func _on_BuyItem3Button_pressed():
	if $ShopSlot3.get_child_count() > 0 and playerStats.gold >= $ShopSlot3.get_child(0).price:
		var item3 = $ShopSlot3.get_child(0)
		if item3 is wepon: item3.scale = Vector2(1,1)
		if item3 is item: item3.scale = Vector2(0.5,0.5)
		
		var price = item3.price
		eq_scripts.pickUpItem(item3,$ShopSlot3,null)
		if $ShopSlot3.get_child_count() == 0: playerStats.gold -= price
		showShop()
