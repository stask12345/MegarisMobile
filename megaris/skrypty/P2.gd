extends Sprite


func closeExit():
	$Ladder.queue_free()
	$StaticBody2D/CollisionShape2DBlocade.disabled = false
