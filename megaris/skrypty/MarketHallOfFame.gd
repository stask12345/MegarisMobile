extends Sprite

onready var enterButton = get_node("/root/MainScene/CanvasLayer/Control4/Enter")
onready var HallMenu = get_node("/root/MainScene/CanvasLayer/Control4/HallMenu")

func _on_Area2D_area_entered(area):
	if area.get_parent().name == "Player":
		HallMenu.calculateSkillModifications()
		enterButton.menuToEnter = HallMenu
		enterButton.get_node("AnimationPlayer").play("pick_up_sight_animation")
		enterButton.get_node("Label").text = "Player Stats and Quests"
		enterButton.visible = true


func _on_Area2D_area_exited(area):
	if area.get_parent().name == "Player":
		enterButton.get_node("AnimationPlayer").stop()
		enterButton.menuToEnter.visible = false
		enterButton.visible = false
		enterButton.get_node("Label").text = ""
