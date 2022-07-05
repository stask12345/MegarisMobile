extends KinematicBody2D
class_name bullet
var bulletRange = 0 # w sekundach do zniszczenia
var destroyed = false
onready var wepon = get_node("/root/MainScene/CanvasLayer/Control4/WeponHolder").get_child(0)
onready var player = get_node("/root/MainScene/Player/WeponHolder")
onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var effectGenerator = get_node("/root/MainScene/EffectGenerator")
onready var mainNode = get_node("/root/MainScene")
var direction

func _ready():
	bulletRange = wepon.bulletRange
	if wepon.rangeDestroy: timerToDestroy()
	
	set_position(global_position)
	get_parent().remove_child(self)
	mainNode.add_child(self)
	direction = player.scale.x

func timerToDestroy():
	yield(get_tree().create_timer(bulletRange),"timeout")
	if !destroyed: queue_free()

func destroyAfterAnimation(): #wywolywane przez animation pleyera
	queue_free()

func attackMonster(monster):
	if !monster.destroyed:
		monster.hpDelay = true
		monster.hpDelayTimer()
		var damage = randi()%(wepon.maxDamage - wepon.minDamage + 1) + wepon.minDamage
		damage = damage * playerStats.strengthIncrease
		monster.hp -= damage
		effectGenerator.generateDamageLabel(global_position,damage)
		monster.get_knock(monster.goingRight)
		monster.triggerMonster()
		if monster.hp <= 0: monster.playAnimationAndDestroy()
