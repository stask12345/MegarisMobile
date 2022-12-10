extends RigidBody2D

onready var money = get_node("/root/MainScene/CanvasLayer/Control3")
var destroyed = false

func _exit_tree():
	queue_free()

func destroyAfterAnimation():
	queue_free()

func playAnimation():
	$AnimationPlayer.play("picking")


func _on_Area2D_body_entered(body):
	if body.name == "Player" and !destroyed:
		destroyed = true
		get_node("/root/MainScene/MusicPlayer").playCoin()
		money.gold += 1
		money.totalCollected += 1
		if money.gold > money.maxGoldAcquired: money.maxGoldAcquired = money.gold
		if get_child_count() > 0 and get_child(0).name == "coin": $Coin.queue_free()
		playAnimation()
