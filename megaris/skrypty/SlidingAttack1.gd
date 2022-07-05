extends KinematicBody2D

var motion = Vector2()
var attackStrenght = 25
var goingRight = false
onready var player = get_node("/root/MainScene/Player")
var shootingMonster

func _physics_process(delta):
	if goingRight: motion = Vector2(30000,0)
	else: motion = Vector2(-30000,0)
	move_and_slide(motion * delta)

func timerToDestroy(time):
	$Timer.start(time)
	yield($Timer, "timeout")
	queue_free()
