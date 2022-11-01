extends monsterClass

onready var attackBolt = preload("res://instances/Bullets/Monster-bullet-Worm.tscn")
var canShoot = true
var ladderOrWall = false
var directionOfBlocade = false
var shooting = false

func _ready():
	minCoins = 4
	maxCoins = 5
	attackStrenght = 45
	hp = 110
	monsterName = "Mutated Worm"

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
	var b1 = attackBolt.instance()
	var height = position.y - 20
	var width = position.x
	b1.shootingMonster = duplicate()
	if goingRight: b1.scale.x = 1
	else: b1.scale.x = -1
	
	get_node("/root/MainScene/MusicPlayer").playMonsterShoot()
	
	if goingRight == false: b1.goingRight = false
	else: b1.goingRight = true
	
	var rotationOfAttack
	var distance = (global_position - player.global_position).length()
	rotationOfAttack = 0.44
	if (player.position.y - 30) > position.y: 
		rotationOfAttack = 0.02
	if goingRight: b1.rotate(-rotationOfAttack)
	else: b1.rotate(rotationOfAttack)
	b1.position.y = height
	b1.position.x = width
	get_parent().add_child(b1)
