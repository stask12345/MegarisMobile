extends Sprite

onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var skillInScript
onready var pickUpButton = get_node("/root/MainScene/CanvasLayer/Control4/PickUp")
onready var buyButton = get_node("/root/MainScene/CanvasLayer/Control4/Buy")
onready var itemBody
var itemSold = false
var maxHeight = -70
var minHeight = -50
var speed = 1000
var velocity = Vector2(0,0)
var target = Vector2(0,0)
var target1 = Vector2(0,0)
var movingUp = true

func _readyItem():
	itemSold = true
	if get_child(0).get_child_count() > 0: skillInScript = get_child(0).get_child(0)
	itemBody = get_child(0)
	target = Vector2(itemBody.position.x,maxHeight)
	target1 = Vector2(itemBody.position.x,minHeight)
	if skillInScript != null:
		showCostLabel()

func _physics_process(delta):
	if (itemBody == null and !itemSold):
		_readyItem()
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
			pickUpButton.tableToPickUpFrom = self
			var animationPlayer = pickUpButton.get_child(0)
			animationPlayer.play("pick_up_sight_animation")
		
		if (skillInScript is skill and !skillInScript.rewardSkill) or skillInScript is wepon or skillInScript is item:
				buyButton.objectToBuy = skillInScript
				buyButton.tableToPickUpFrom = self
				if skillInScript is skill: buyButton.get_child(2).text = skillInScript.description
				if skillInScript is wepon or skillInScript is item: buyButton.get_child(2).text = skillInScript.title
				buyButton.visible = true
				var animationPlayer = buyButton.get_child(0)
				animationPlayer.play("pick_up_sight_animation")


func _on_Area2D_body_exited(body):
	if body.name == "Player" and itemBody.get_child_count() > 0:
		if skillInScript is skill and skillInScript.rewardSkill:
			pickUpButton.visible = false
			pickUpButton.get_child(2).text = ""
			pickUpButton.tableToPickUpFrom = null
			var animationPlayer = pickUpButton.get_child(0)
			animationPlayer.stop()
		
		if (skillInScript is skill and !skillInScript.rewardSkill) or skillInScript is wepon or skillInScript is item:
			buyButton.visible = false
			buyButton.get_child(2).text = ""
			buyButton.tableToPickUpFrom = null
			var animationPlayer = buyButton.get_child(0)
			animationPlayer.stop()

func showCostLabel():
	if skillInScript != null and (skillInScript is skill and !skillInScript.rewardSkill) or skillInScript is wepon or skillInScript is item:
		$Label.text = String(skillInScript.costOfSkill)
		$Label.visible = true
	else: 
		$Label.visible = false

func playEffectAnimation():
	$ItemTableAnimation/AnimationPlayer.play("idle")
