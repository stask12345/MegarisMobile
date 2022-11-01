extends item

onready var playerHealth = get_node("/root/MainScene/CanvasLayer/Control3/Hp")
onready var player = get_node("/root/MainScene/Player")
var healPower = 100


func _ready():
	title = "Healing IV"
	usable = true
	price = 100
	description = "Super healing potion\nHeals: " + String(healPower) + " HP"
	costOfSkill = 25
	tier = 5

func use():
	playerHealth.hp += healPower
	player.changeColor(Color.green,true)
	get_node("/root/MainScene/MusicPlayer").playDrink()
	queue_free()
