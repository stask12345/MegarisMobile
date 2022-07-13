extends Sprite

onready var skillInScript = get_child(0).get_child(0)
onready var pickUpButton = get_node("/root/MainScene/CanvasLayer/Control4/PickUp")
onready var buyButton = get_node("/root/MainScene/CanvasLayer/Control4/Buy")
onready var itemBody : KinematicBody2D = get_child(0)
var maxHeight = -70
var minHeight = -50
var speed = 1000
var velocity = Vector2(0,0)
var target = Vector2(0,0)
var target1 = Vector2(0,0)
var movingUp = true

func _ready():
	target = Vector2(itemBody.position.x,maxHeight)
	target1 = Vector2(itemBody.position.x,minHeight)

func _physics_process(delta):
	if skillInScript and itemBody is KinematicBody2D:
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
	if body.name == "Player" and itemBody.get_child_count() > 0:
		if skillInScript is skill and skillInScript.rewardSkill:
			pickUpButton.get_child(2).text = skillInScript.description
			pickUpButton.visible = true
			pickUpButton.itemToPick = skillInScript
			var animationPlayer = pickUpButton.get_child(0)
			animationPlayer.play("pick_up_sight_animation")
		
		if skillInScript is skill and !skillInScript.rewardSkill:
			buyButton.objectToBuy = skillInScript
			buyButton.get_child(2).text = skillInScript.description
			buyButton.visible = true
			var animationPlayer = buyButton.get_chold(0)
			animationPlayer.play("buy_sight_animation")


func _on_Area2D_body_exited(body):
	if body.name == "Player" and itemBody.get_child_count() > 0:
		if skillInScript is skill and skillInScript.rewardSkill:
			pickUpButton.visible = false
			pickUpButton.get_child(2).text = ""
			var animationPlayer = pickUpButton.get_child(0)
			animationPlayer.stop()
		
		if skillInScript is skill and !skillInScript.rewardSkill:
			buyButton.visible = false
			buyButton.get_child(2).text = ""
			var animationPlayer = buyButton.get_chold(0)
			animationPlayer.stop()
