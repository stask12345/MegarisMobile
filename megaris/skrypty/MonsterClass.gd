extends KinematicBody2D
class_name monsterClass

onready var player = get_node("/root/MainScene/Player")
onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var goldCoin = preload("res://instances/Elements/Coin.tscn") 
var goingToPlayer = false
var goingRight = false
var motion = Vector2()
var destroyed = false
var hpDelay = false
var aggro = false
var playerInRange = false
var flying = false
var gravity = 80
var maxGravity = 800
var knockbackLength = 5 #knockback
var knockbackMaxLength = 4
var knockbackStrength = 750
var knockbackDirection = false
var attackStrenght = 40 #statystyki zmienne
var hp = 100
var minCoins
var maxCoins
var monsterName : String
var triggerTime = 1
var getBack
var indestructable = false
var isBossMonster = false
var isSlimeMonster = false
var isSkeletonMonster = false

onready var timer = $Timer

func _ready():
	pass

func get_knock(direction): #knockback z obrażeń #direction ture - prawo #wiecej ustawien w skrypcie u góry
	knockbackLength = 0
	knockbackDirection = !direction

func hpDelayTimer():
	yield(get_tree().create_timer(0.1), "timeout") #może generować problemy
	hpDelay = false

func loseTriggerOnPlayer():
	goingToPlayer = false
	if player.alive and !destroyed:
		timer.start(triggerTime)
		yield($Timer, "timeout")
	if !goingToPlayer: aggro = false

func triggerMonster():
	goingToPlayer = true
	aggro = true

func dropGold():
	if isSlimeMonster: playerStats.slimesSlayed += 1
	if isSkeletonMonster: playerStats.skeletonsSlayed += 1
	
	var generatedCoins = minCoins + randi()%(maxCoins + playerStats.bonusCoins - minCoins)
	while generatedCoins >= 0:
		var coin = goldCoin.instance()
		coin.global_position = global_position
		var xPosition = randi()%35
		if randi()%2 == 0: 
			coin.position.x += xPosition
			coin.linear_velocity.x = randi()%40
		else: 
			coin.position.x -= xPosition
			coin.linear_velocity.x = -randi()%40
		coin.position.y -= randi()%30
		coin.linear_velocity.y = -randi()%100
		coin.rotation_degrees += randi()%90
		coin.rotation_degrees -= randi()%90
		get_parent().add_child(coin)
		generatedCoins -= 1

func playAnimationAndDestroy():
	playerStats.killedMonster += 1
	destroyed = true
	$AnimationPlayer.play("monster_death")
