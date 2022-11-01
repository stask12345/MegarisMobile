extends item

onready var playerHealth = get_node("/root/MainScene/CanvasLayer/Control3/Hp")
onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var player = get_node("/root/MainScene/Player")
var invisibleTime = 5

func _ready():
	title = "Invisibility I"
	usable = true
	price = 50
	description = "Makes you invisibe \nDuration: " + String(invisibleTime) + " sec."
	costOfSkill = 15
	tier = 3

func use():
	playerStats.make_invisible(invisibleTime)
	player.changeColor(Color.blue,true)
	get_node("/root/MainScene/MusicPlayer").playDrink()
	queue_free()
