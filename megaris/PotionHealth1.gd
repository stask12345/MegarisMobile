extends item

onready var playerHealth = get_node("/root/MainScene/CanvasLayer/Control3/Hp")
onready var player = get_node("/root/MainScene/Player")
var additionalHealth = 20


func _ready():
	title = "Health I"
	usable = true
	price = 70
	description = "Health potion\nPermanently adds " + String(additionalHealth) + " HP"

func use():
	playerHealth.maxHp += additionalHealth
	playerHealth.hp += additionalHealth
	player.changeColor(Color.green,true)
	queue_free()
