extends Sprite

var menuToEnter

func _on_Button_pressed():
	menuToEnter.visible = true
	if menuToEnter.name != "HallMenu" and menuToEnter.name != "ShopMenu" and menuToEnter.name != "AnvilMenu": get_node("/root/MainScene/MusicPlayer").playChest()
	visible = false
