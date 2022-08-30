extends KinematicBody2D
class_name bullet
var bulletRange = 0 # w sekundach do zniszczenia
var destroyed = false
var shorterRange = false #dla pocisków strzelających z kregów przyzwania specialu4
var doubleArrowsRotated = false #dla double arrows by ustawić rotację
var scroolBullet = false
var scroolDamage = 0
onready var wepon = get_node("/root/MainScene/CanvasLayer/Control4/WeponHolder").get_child(0)
onready var player = get_node("/root/MainScene/Player/WeponHolder")
onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var effectGenerator = get_node("/root/MainScene/EffectGenerator")
onready var mainNode = get_node("/root/MainScene")
var direction

func _ready():
	if !shorterRange: 
		if playerStats.bulletRangeImprovement == 0: bulletRange = wepon.bulletRange
		else: bulletRange = wepon.bulletRange * playerStats.bulletRangeImprovement
	else: bulletRange = 1
	
	if wepon.rangeDestroy: 
		timerToDestroy()
	
	if get_parent() == null || get_parent().name == "WeponHolder": set_position(global_position)
	else: get_parent().set_position(get_parent().global_position)
	
	if get_parent().name == "WeponHolder": get_parent().remove_child(self)
	else: get_parent().get_parent().remove_child(get_parent())
	
	if get_parent() == null || get_parent().name == "WeponHolder": mainNode.add_child(self)
	else: 
		if get_parent().name != "MainScene": mainNode.add_child(self.get_parent())
	direction = player.scale.x

func timerToDestroy():
	$TimerD.start(bulletRange)
	yield($TimerD,"timeout")
	if !destroyed: queue_free()

func destroyAfterAnimation(): #wywolywane przez animation pleyera
	queue_free()

func attackMonster(monster):
	if !monster.destroyed:
		monster.hpDelay = true
		monster.hpDelayTimer()
		var damage
		if !scroolBullet:  damage = randi()%(wepon.maxDamage - wepon.minDamage + 1) + wepon.minDamage
		else: damage = scroolDamage
		damage = damage * playerStats.strengthIncrease
		damage = damage * playerStats.maxDamageIncrease
		if monster.isBossMonster == true: damage = damage * playerStats.bossSlayerBonus
		if monster.isSlimeMonster == true: damage = damage * playerStats.slimeAttackBonus
		damage = round(damage)
		monster.hp -= damage
		effectGenerator.generateDamageLabel(global_position,damage)
		monster.get_knock(monster.goingRight)
		var monsterAlreadyTriggered = monster.goingToPlayer;
		monster.triggerMonster()
		if !monsterAlreadyTriggered: monster.loseTriggerOnPlayer()
		if monster.hp <= 0: monster.playAnimationAndDestroy()

func rotateAllArrowsInDouble():
	var arrows = get_parent().get_children()
	var rotationD = get_parent().rotation_degrees
	get_parent().rotation_degrees = 0
	for a in arrows:
		a.rotation_degrees = rotationD
		a.scale.x = get_parent().scale.x
		a.doubleArrowsRotated = true
	get_parent().scale.x = 1
