extends item

onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var player = get_node("/root/MainScene/Player")
var strongerTime = 10

func _ready():
	title = "Strenght II"
	usable = true
	price = 150
	description = "Damage x2 \nDuration: " + String(strongerTime) + " sec."
	costOfSkill = 20
	tier = 5

func use():
	playerStats.make_stronger(strongerTime)
	player.changeColor(Color.red,true)
	get_node("/root/MainScene/MusicPlayer").playDrink()
	queue_free()
