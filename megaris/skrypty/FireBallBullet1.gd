extends KinematicBody2D

onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var effectGenerator = get_node("/root/MainScene/EffectGenerator")
var bulletRange
var destroyed = false
var damage = 0

func _ready():
	bulletRange = 1
	timerToDestroy()

func _process(_delta):
	if !destroyed:
		move_and_slide(Vector2(550,0).rotated(rotation))
	if destroyed:
		$AnimationPlayer.play("destroyAnimation")


func _on_Area2D_area_entered(area): #kontakt z mobkiem Area_attack
	if area.name == "monsterBody":
		var monster = area.get_parent()
		if !monster.hpDelay:
			attackMonster(monster)

func attackMonster(monster):
	if !monster.destroyed:
		monster.hpDelay = true
		monster.hpDelayTimer()
		var attackdDamage = damage
		attackdDamage = attackdDamage * playerStats.strengthIncrease
		monster.hp -= attackdDamage
		effectGenerator.generateDamageLabel(monster.global_position,attackdDamage)
		monster.get_knock(monster.goingRight)
		var monsterAlreadyTriggered = monster.goingToPlayer;
		monster.triggerMonster()
		if !monsterAlreadyTriggered: monster.loseTriggerOnPlayer()
		if monster.hp <= 0: monster.playAnimationAndDestroy()

func timerToDestroy():
	yield(get_tree().create_timer(bulletRange),"timeout")
	if !destroyed: $AnimationPlayer.play("destroyAnimation")

func destroyAfterAnimation(): #wywolywane przez animation pleyera
	queue_free()
