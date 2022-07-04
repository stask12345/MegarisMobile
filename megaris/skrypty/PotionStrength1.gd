extends item

onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var player = get_node("/root/MainScene/Player")
var strongerTime = 10

func _ready():
	title = "Strenght I"
	usable = true
	price = 75
	description = "Damage x2 \nDuration: " + String(strongerTime) + " sec."

func use():
	playerStats.make_stronger(strongerTime)
	player.changeColor(Color.red,true)
	queue_free()
