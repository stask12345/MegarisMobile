extends Sprite
onready var player = get_node("/root/MainScene/Player")
onready var hpStat = get_node("/root/MainScene/CanvasLayer/Control3/Hp")
var damage = 15

func _ready():
	pass


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player.trapped = true
		hpStat.dealDamagePlayer(damage)
		player.get_damage_without_knockback()
		frame = 1
		yield(get_tree().create_timer(0.5),"timeout")
		player.trapped = false
		get_child(0).queue_free()
