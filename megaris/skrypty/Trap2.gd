extends trap

func _ready():
	damage = 30

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		used = true
		player.trapped = true
		hpStat.dealDamagePlayer(damage)
		get_node("/root/MainScene/CanvasLayer/Control-DeathScreen").changeKillerMonster(self)
		player.get_damage_without_knockback()
		frame = 1
		get_node("/root/MainScene/MusicPlayer").playTrap()
		yield(get_tree().create_timer(0.5),"timeout")
		player.trapped = false
		get_child(0).queue_free()
