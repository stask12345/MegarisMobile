extends item

onready var playerHealth = get_node("/root/MainScene/CanvasLayer/Control3/Hp")
onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var player = get_node("/root/MainScene/Player")
var invisibleTime = 10

func _ready():
	title = "Invisibility II"
	usable = true
	price = 150
	description = "Makes you invisibe \nDuration: " + String(invisibleTime) + " sec."
	costOfSkill = 15
	tier = 5

func use():
	playerStats.make_invisible(invisibleTime)
	player.changeColor(Color.blue,true)
	queue_free()
