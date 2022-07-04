extends item

onready var playerHealth = get_node("/root/MainScene/CanvasLayer/Control3/Hp")
onready var player = get_node("/root/MainScene/Player")
var healPower = 30


func _ready():
	title = "Healing I"
	usable = true
	price = 30
	description = "Small healing potion\nHeals: " + String(healPower) + " HP"

func use():
	playerHealth.hp += healPower
	player.changeColor(Color.green,true)
	queue_free()
