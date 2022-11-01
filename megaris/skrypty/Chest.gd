extends Sprite

onready var chestMenu = get_node("/root/MainScene/CanvasLayer/Control4/ChestMenu")
onready var openButton = get_node("/root/MainScene/CanvasLayer/Control4/Open")
onready var eq_scripts = get_node("/root/MainScene/CanvasLayer")
var visibleFrame

func _ready():
	if frame != 2: 
		visibleFrame = randi()%2 #losowanie grafiki skrzyni
		frame = visibleFrame
	if get_child_count() > 2: get_child(2).visible = false

func _on_Area2D_body_entered(body):
	if body.name == "Player" and get_child_count() > 2:
		chestMenu.showChest(get_child(2))
		openButton.visible = true
		var animationPlayer = openButton.get_child(0)
		openButton.menuToEnter = chestMenu
		animationPlayer.play("pick_up_sight_animation")


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		openButton.visible = false
		openButton.get_child(0).stop()
		chestMenu.visible = false

func emptyChest():
	if visibleFrame:
		visibleFrame += 2
		frame = visibleFrame
	else:
		frame = 2

func getItem(): #Dla zapisu danych
	if get_child_count() > 2:
		return get_child(2).filename
	else:
		return null
