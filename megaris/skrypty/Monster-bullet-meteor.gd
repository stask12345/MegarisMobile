extends KinematicBody2D

var motion = Vector2()
var attackStrenght = 50
var goingRight = false
var destroyed = false
var direction
var flying = false
var shootingMonster
onready var player = get_node("/root/MainScene/Player")

func _ready():
	direction = goingRight
	var time = 2
	if !shootingMonster: time = 4
	yield(get_tree().create_timer(time), "timeout")
	destroyed = true

func _physics_process(_delta):
	if !destroyed:
		move_and_slide(Vector2(375,0).rotated(rotation))
	if destroyed:
		$AnimationPlayer.play("destroyAnimation")

func destroyAfterAnimation(): #wywolywane przez animation pleyera
	queue_free()
