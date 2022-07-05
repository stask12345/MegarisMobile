extends RigidBody2D

onready var money = get_node("/root/MainScene/CanvasLayer/Control3")

func _ready():
	pass

func _exit_tree():
	queue_free()

func destroyAfterAnimation():
	queue_free()

func playAnimation():
	$AnimationPlayer.play("picking")


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		money.gold += 1
		money.totalCollected += 1
		if $Coin: $Coin.queue_free()
		playAnimation()
