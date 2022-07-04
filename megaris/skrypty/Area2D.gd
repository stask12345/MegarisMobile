extends Area2D

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		var player = body.get_parent().get_node("Player")
		player.onLadder = true
		player.motion.y = 0
		player.motion.x = 0




func _on_Area2D_body_exited(body):
	if body.name == "Player":
		var player = body.get_parent().get_node("Player")
		player.onLadder = false
		player.maxJump = 10000
		player.canJump = false
		player.jumped = true
		player.gravity = 80
		player.jumpPower = 1300
