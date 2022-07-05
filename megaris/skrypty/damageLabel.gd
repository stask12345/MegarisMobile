extends Label

func _ready():
	destroyAfterTime()

func _process(delta):
	rect_position.y -= 1
	

func destroyAfterTime():
	yield(get_tree().create_timer(0.5),"timeout")
	queue_free()
