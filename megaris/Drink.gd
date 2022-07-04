extends Sprite

var fountain

func drinkWaterFromHealingFountain():
	fountain.drink()
	visible = false


func _on_Button_pressed():
	drinkWaterFromHealingFountain()
