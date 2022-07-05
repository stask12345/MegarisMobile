extends Sprite

onready var enterButton = get_node("/root/MainScene/CanvasLayer/Control4/Enter")
onready var anvilMenu = get_node("/root/MainScene/CanvasLayer/Control4/AnvilMenu")
onready var weponHolder = get_node("/root/MainScene/CanvasLayer/Control4/WeponHolder")

func _on_Area2D_body_entered(body):
	if body.name == "Player" and weponHolder.get_child_count() > 0:
		anvilMenu.showArmory()
		enterButton.visible = true
		var animationPlayer = enterButton.get_child(0)
		enterButton.menuToEnter = anvilMenu
		animationPlayer.play("pick_up_sight_animation")


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		enterButton.visible = false
		enterButton.get_child(0).stop()
		anvilMenu.visible = false
