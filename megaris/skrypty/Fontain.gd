extends Sprite

onready var playerHp = get_node("/root/MainScene/CanvasLayer/Control3/Hp")
onready var drinkButton = get_node("/root/MainScene/CanvasLayer/Control4/Drink")
var full = true

func _ready():
	if !full:
		$AnimationPlayer.play("empty")

func drink(): #wywoływana z przycisku drink
	get_node("/root/MainScene/MusicPlayer").playFountain()
	playerHp.hp = playerHp.maxHp
	full = false
	$Area2D.monitoring = false
	$AnimationPlayer.play("empty")
	$ItemTableAnimation/AnimationPlayer.play("idle")

func makeEmpty(): #przy loadData
	full = false
	$Area2D.monitoring = false
	$AnimationPlayer.play("empty")

func _on_Area2D_body_entered(body):
	if body.name == "Player" and full:
		drinkButton.fountain = self
		drinkButton.visible = true
		var animationPlayer = drinkButton.get_child(0)
		animationPlayer.play("pick_up_sight_animation")


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		drinkButton.visible = false
		drinkButton.get_child(0).stop()
		drinkButton.visible = false
