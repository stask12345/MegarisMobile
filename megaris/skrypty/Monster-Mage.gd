extends monsterClass

var bat = preload("res://instances/Monsters/Monster-Bat.tscn")
var slime = preload("res://instances/Monsters/Monster-Slime.tscn")
var skeleton = preload("res://instances/Monsters/Monster-Skeleton.tscn")
var canShoot = true
var ladderOrWall = false
var directionOfBlocade = false
var shooting = false

func _ready():
	minCoins = 3
	maxCoins = 6
	attackStrenght = 30 
	hp = 100
	monsterName = "Skeleton Mage"
	isSkeletonMonster = true

func _physics_process(delta):
	motion.y += gravity #grawitacja
	if motion.y >= maxGravity:
		motion.y = maxGravity
	
	if goingToPlayer: #kierunek w którym idzie wróg
		if global_position.x - player.global_position.x >= 0:
			goingRight = false
			$Monster1.scale.x = 1
		else:
			goingRight = true
			$Monster1.scale.x = -1
	
	motion.x = 0
	if aggro and !destroyed:
		if !playerInRange and !shooting:
			if goingRight:
				if (!ladderOrWall or !directionOfBlocade):
					motion.x = 5000
					$AnimationPlayer.play("walk")
			if !goingRight:
				if (!ladderOrWall or directionOfBlocade):
					motion.x = -5000
					$AnimationPlayer.play("walk")
			if motion.x == 0: $AnimationPlayer.play("idle")
		else:
			if canShoot:
				shooting = true
				$AnimationPlayer.play("charge")
			if !canShoot and !shooting:
				if getBack:
					if goingRight and (!ladderOrWall or directionOfBlocade):
						motion.x = -5000
						$AnimationPlayer.play("walk")
					
					if !goingRight and (!ladderOrWall or !directionOfBlocade):
						motion.x = 5000
						$AnimationPlayer.play("walk")
				if !getBack: $AnimationPlayer.play("idle")
	if !aggro and !destroyed:
		$AnimationPlayer.play("idle")
	
	if knockbackLength < knockbackMaxLength: #knockback
		if knockbackDirection: motion.x = knockbackStrength
		else: motion.x = -knockbackStrength
		knockbackLength += 1
		modulate = Color(1,0,0)
	else : 
		modulate = Color(1,1,1)
	
	
	motion.x = motion.x * delta
	if !destroyed: move_and_slide(motion,Vector2(0,-1))
	

func shoot():
	canShoot = false
	shooting = false
	shootBullets()
	waitForShoot()

func waitForShoot():
	$Timer2.start(2)
	yield($Timer2,"timeout")
	canShoot = true

func destroyMonster():
	dropGold()
	queue_free()


func shootBullets():
	var monsterType = randi()%3
	var summonedMonster
	if monsterType == 0: summonedMonster = bat.instance()
	if monsterType == 1: summonedMonster = slime.instance()
	if monsterType == 2: summonedMonster = skeleton.instance()
	if scale.x == -1: summonedMonster.global_position = Vector2(position.x - 60, global_position.y)
	else: summonedMonster.global_position = Vector2(position.x + 60, global_position.y)
	summonedMonster.minCoins = 0
	summonedMonster.maxCoins = 1
	get_parent().add_child(summonedMonster)
