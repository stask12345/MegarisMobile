extends item

onready var playerHealth = get_node("/root/MainScene/CanvasLayer/Control3/Hp")
onready var player = get_node("/root/MainScene/Player")
var healPower = 75


func _ready():
	title = "Healing III"
	usable = true
	price = 75
	costOfSkill = 15
	description = "Big healing potion\nHeals: " + String(healPower) + " HP"
	tier = 4

func use():
	playerHealth.hp += healPower
	player.changeColor(Color.green,true)
	get_node("/root/MainScene/MusicPlayer").playDrink()
	queue_free()
