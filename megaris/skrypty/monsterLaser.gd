extends Sprite

var attackStrenght = 50
var destroyed = false
var shootingMonster
var goingRight = false
onready var player = get_node("/root/MainScene/Player")

func destroyAfterAnimation(): #wywolywane przez animation pleyera
	queue_free()
