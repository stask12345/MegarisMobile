extends item

onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var player = get_node("/root/MainScene/Player")
onready var bold = preload("res://instances/Bullets/spellExplosionBullet1.tscn")
var damage = 100

func _ready():
	title = "Explosion II"
	usable = true
	price = 40
	description = "Fires a powerful exposion. \nDamage: " + String(damage)

func use():
	var b = bold.instance()
	b.damage = damage
	b.scale.x = player.get_node("Player").scale.x
	b.global_position = player.global_position
	get_node("/root/MainScene").add_child(b)
	queue_free()
