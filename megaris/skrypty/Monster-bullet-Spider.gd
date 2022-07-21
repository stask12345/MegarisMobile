extends KinematicBody2D

var motion = Vector2()
var attackStrenght = 30
var goingRight = false
var destroyed = false
var direction
var flying = false
var shootingMonster
onready var player = get_node("/root/MainScene/Player")

func _ready():
	direction = goingRight
	attackStrenght = shootingMonster.attackStrenght

func _physics_process(delta):
	if !destroyed:
		if direction == false and (global_rotation_degrees > 90 or global_rotation_degrees < 0): rotation = rotation - 0.04
		if direction == true and (global_rotation_degrees < 90 or global_rotation_degrees < 0): rotation = rotation + 0.04
		move_and_slide(Vector2(700,0).rotated(rotation))
		if $BulletMonster1.rotation > 120: $BulletMonster1.rotate(0.02)
	if destroyed:
		$AnimationPlayer.play("destroyAnimation")

func destroyAfterAnimation(): #wywolywane przez animation pleyera
	queue_free()

func _on_Area2D_body_entered(body): #konktakt z ziemią
	destroyed = true
