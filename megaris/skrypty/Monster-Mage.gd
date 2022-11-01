extends monsterClass

var bat = preload("res://instances/Monsters/Monster-Bat2.tscn")
var slime = preload("res://instances/Monsters/Monster-RedSlime.tscn")
var skeleton = preload("res://instances/Monsters/Monster-Skeleton.tscn")
var canShoot = true
var ladderOrWall = false
var directionOfBlocade = false
var shooting = false

func _ready():
	minCoins = 3
	maxCoins = 6
	attackStrenght = 30 
	hp = 140
	monsterName = "Skeleton Mage"
	isSkeletonMonster = true

func _physics_process(delta):
	if get_parent().visible == true:
		if motion.y < maxGravity:
			motion.y += gravity #grawitacja
			if motion.y >= maxGravity:
				motion.y = maxGravity
		
		if aggro: #kierunek w którym idzie wróg
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
					if !getBack and !destroyed: $AnimationPlayer.play("idle")
		if !aggro and !destroyed and !shooting:
			$AnimationPlayer.play("idle")
		
		if knockbackLength < knockbackMaxLength: #knockback
			if knockbackDirection: motion.x = knockbackStrength
			else: motion.x = -knockbackStrength
			knockbackLength += 1
			modulate = Color(1,0,0)
		else : 
			modulate = Color(1,1,1)
		
		
		motion.x = motion.x * delta
		if !destroyed:
			if motion.x != 0 or motion.y != maxGravity:
				 move_and_slide(motion,Vector2(0,-1))
		

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
	$SoundEffectSummon.play()
	var monsterType = randi()%3
	var summonedMonster
	if monsterType == 0: summonedMonster = bat.instance()
	if monsterType == 1: summonedMonster = slime.instance()
	if monsterType == 2: summonedMonster = skeleton.instance()
	if $Monster1.scale.x == -1: summonedMonster.position = Vector2(position.x + 60, global_position.y)
	else: summonedMonster.position = Vector2(position.x - 60, global_position.y)
	get_parent().add_child(summonedMonster)
	summonedMonster.minCoins = 0
	summonedMonster.maxCoins = 1
