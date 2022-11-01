extends monsterClass

onready var attackBolt = preload("res://instances/Bullets/Monster-bullet-Spider.tscn")
var exposed = false
var canShoot = true
var powerfullShoot = true

func _ready():
	minCoins = 4
	maxCoins = 8
	attackStrenght = 50 #statystyki zmienne
	hp = 200
	monsterName = "Chest Mimic"

func _physics_process(delta):
	if get_parent().visible == true:
		if motion.y < maxGravity:
			motion.y += gravity #grawitacja
			if motion.y >= maxGravity:
				motion.y = maxGravity
		
		if aggro and !destroyed:
			if global_position.x - player.global_position.x >= 0:
				goingRight = false
			else:
				goingRight = true
			
			if !exposed:
				get_node("/root/MainScene/MusicPlayer").playMonsterGrowl()
				$AnimationPlayer.play("monsterExpose")
			
			if exposed:
				$AnimationPlayer.play("idle")
				if canShoot: shoot()
		
		
		if knockbackLength < knockbackMaxLength: #knockback
			knockbackLength += 1
			modulate = Color(1,0,0)
		else : 
			modulate = Color(1,1,1)

func startShooting():
	exposed = true
	$TriggerArea/CollisionShape2D.scale.x = 2

func shoot():
	canShoot = false
	
#	shootSingleStrongBold()

	get_node("/root/MainScene/MusicPlayer").playMonsterShoot()
	
	if powerfullShoot:
		var b1 = attackBolt.instance()
		var b2 = attackBolt.instance()
		var b3 = attackBolt.instance()
		var b4 = attackBolt.instance()
		var height = position.y
		var width = position.x
		b1.shootingMonster = self
		b2.shootingMonster = self
		b3.shootingMonster = self
		b4.shootingMonster = self
		b3.scale.x = -1
		b4.scale.x = -1
		b1.goingRight = true
		b3.goingRight = false
		b2.goingRight = true
		b4.goingRight = false
		b1.rotate(0.1)
		b3.rotate(-0.1)
		b2.rotate(-0.4)
		b4.rotate(0.4)
		b1.position = Vector2(width, height-30)
		b2.position = Vector2(width, height-20)
		b3.position = Vector2(width, height-30)
		b4.position = Vector2(width, height-20)
		get_parent().add_child(b1)
		get_parent().add_child(b2)
		get_parent().add_child(b3)
		get_parent().add_child(b4)
		powerfullShoot = false
	else:
		shootSingleStrongBold()
	
	$Timer2.start(3)
	yield($Timer2,"timeout")
	canShoot = true

func shootSingleStrongBold():
	var b1 = attackBolt.instance()
	var height = position.y - 20
	var width = position.x
	b1.shootingMonster = self
	if goingRight: b1.scale.x = 1
	else: b1.scale.x = -1
	
	if goingRight == false: b1.goingRight = false
	else: b1.goingRight = true
	
	var rotationOfAttack
	var distance = (global_position - player.global_position).length()
	if distance < 175: rotationOfAttack = -0.1
	else: rotationOfAttack = 0.40
	if goingRight: b1.rotate(-rotationOfAttack)
	else: b1.rotate(rotationOfAttack)
	b1.position.y = height
	b1.position.x = width
	get_parent().add_child(b1)

func destroyMonster():
	dropGold()
	queue_free()
