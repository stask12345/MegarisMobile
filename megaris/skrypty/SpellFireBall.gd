extends item

onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var player = get_node("/root/MainScene/Player")
onready var bold = preload("res://instances/Bullets/FireBallBullet.tscn")
var damage = 60

func _ready():
	title = "FireBall I"
	usable = true
	price = 30
	description = "Fires a powerful bold. \nDamage: " + String(damage)
	costOfSkill = 10

func use():
	var b = bold.instance()
	b.damage = damage
	b.scale.x = player.get_node("Player").scale.x
	b.global_position = player.global_position
	get_node("/root/MainScene").add_child(b)
	queue_free()
