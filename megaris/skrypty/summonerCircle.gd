extends KinematicBody2D

var slime = preload("res://instances/Monsters/Monster-GoldenSlime.tscn")
var bat = preload("res://instances/Monsters/Monster-Bat5.tscn")
var skeleton = preload("res://instances/Monsters/Monster-SkeletonWarrior.tscn")
var golem = preload("res://instances/Monsters/Monster-FireGolem.tscn")
var mage = preload("res://instances/Monsters/Monster-Mage2.tscn")
var worm = preload("res://instances/Monsters/Monster-Worm2.tscn")
var monsterList = [slime,bat,skeleton,golem,mage,worm]

func summonMonsterAnimation():
	$TeleportationEffect.position = Vector2(0,0)
	if randi()%2 == 0:
		$TeleportationEffect.position.y += randi()%80
	else: 
		$TeleportationEffect.position.y -= randi()%80
	if randi()%2 == 0:
		$TeleportationEffect.position.x += randi()%80
	else: 
		$TeleportationEffect.position.x -= randi()%80
	$AnimationPlayer2.play("summonAnimation")

func summonMonster():
	var m = monsterList[randi()%monsterList.size()].instance()
	m.set_global_position($TeleportationEffect.global_position)
	m.dropped = true
	get_parent().add_child(m)

func playSummon():
	$SoundEffectSummon.play()

func destroy():
	queue_free()
