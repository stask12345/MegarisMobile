extends item

onready var playerHealth = get_node("/root/MainScene/CanvasLayer/Control3/Hp")
onready var player = get_node("/root/MainScene/Player")
onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
var invisibleTime = 12
var healPower = 200
var strongerTime = 12

func _ready():
	title = "Devine Potion"
	usable = true
	price = 500
	description = "Heals: " + String(healPower) + " HP\n" + "Invisibility: " + String(invisibleTime) + " sec.\n" + "Damage x2: "+ String(strongerTime) + " sec."
	tier = 6

func use():
	playerHealth.hp += healPower
	player.changeColor(Color.green,true)
	playerStats.make_invisible(invisibleTime)
	player.changeColor(Color.blue,true)
	playerStats.make_stronger(strongerTime)
	player.changeColor(Color.red,true)
	queue_free()
