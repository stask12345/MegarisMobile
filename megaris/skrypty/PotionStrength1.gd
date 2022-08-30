extends item

onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var player = get_node("/root/MainScene/Player")
var strongerTime = 5

func _ready():
	title = "Strenght I"
	usable = true
	price = 50
	description = "Damage x2 \nDuration: " + String(strongerTime) + " sec."
	costOfSkill = 15
	tier = 3

func use():
	playerStats.make_stronger(strongerTime)
	player.changeColor(Color.red,true)
	queue_free()
