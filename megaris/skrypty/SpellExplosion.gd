extends item

onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var player = get_node("/root/MainScene/Player")
onready var bold = preload("res://instances/Bullets/spellExplosionBullet.tscn")
var damage = 80

func _ready():
	title = "Explosion I"
	usable = true
	price = 75
	description = "Fires a powerful exposion. \nDamage: " + String(damage)
	costOfSkill = 15
	tier = 3

func use():
	var b = bold.instance()
	b.damage = damage
	b.scale.x = player.get_node("Player").scale.x
	b.global_position = player.global_position
	get_node("/root/MainScene").add_child(b)
	get_node("/root/MainScene/MusicPlayer").playExpolosion()
	queue_free()
