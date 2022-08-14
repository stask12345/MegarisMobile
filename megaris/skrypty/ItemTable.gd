extends Sprite

var itemInScript
onready var pickUpButton = get_node("/root/MainScene/CanvasLayer/Control4/PickUp")
onready var itemBody : KinematicBody2D = get_child(0)
var maxHeight = -70
var minHeight = -50
var speed = 1000
var velocity = Vector2(0,0)
var target = Vector2(0,0)
var target1 = Vector2(0,0)
var movingUp = true

func _ready():
	itemInScript = get_child(0).get_child(0)
	print(itemInScript.name)
	target = Vector2(itemBody.position.x,maxHeight)
	target1 = Vector2(itemBody.position.x,minHeight)

func _physics_process(delta):
	if itemInScript and itemBody is KinematicBody2D:
		if movingUp:
			velocity = itemBody.position.direction_to(target) * speed * delta
			if itemBody.position.distance_to(target) > 3:
				velocity = itemBody.move_and_slide(velocity)
			else: movingUp = false
		else:
			velocity = itemBody.position.direction_to(target1) * speed * delta
			if itemBody.position.distance_to(target1) > 3:
				velocity = itemBody.move_and_slide(velocity)
			else: movingUp = true


func _on_Area2D_body_entered(body):
	if body.name == "Player" and itemInScript:
		pickUpButton.visible = true
		var animationPlayer = pickUpButton.get_child(0)
		pickUpButton.itemToPick = itemInScript
		animationPlayer.play("pick_up_sight_animation")


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		var animationPlayer = pickUpButton.get_child(0)
		animationPlayer.stop()
		pickUpButton.visible = false
