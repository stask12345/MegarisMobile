extends item

onready var playerHealth = get_node("/root/MainScene/CanvasLayer/Control3/Hp")
onready var player = get_node("/root/MainScene/Player")
var healPower = 50


func _ready():
	title = "Healing II"
	usable = true
	price = 60
	description = "Healing potion\nHeals: " + String(healPower) + " HP"

func use():
	playerHealth.hp += healPower
	player.changeColor(Color.green,true)
	queue_free()
