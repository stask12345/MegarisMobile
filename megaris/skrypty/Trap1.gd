extends Sprite
class_name trap
onready var player = get_node("/root/MainScene/Player")
onready var hpStat = get_node("/root/MainScene/CanvasLayer/Control3/Hp")
var damage = 15
var monsterName = "Trap"
var used = false

func _ready():
	pass


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

func makeUsed(): #Przy wczytywaniu danych
	used = true
	frame = 1
	get_child(0).queue_free()
