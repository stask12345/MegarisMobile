extends monsterClass

var attackBolt = preload("res://instances/Bullets/Sliding-monster-bullet.tscn")
var jump = 0 
var jumpPower = 650
var jumpSpeed = 210 # x
var maxJump = 1800
var jumped = false
var ladder = false
var waitingForJump = false
var directionOfLadder = false
var waitingForShooting = false
var shooting = false

func _ready():
	minCoins = 3 #               !!!!!!! Być moze, nieśmiertelny podczas ataku
	maxCoins = 6
	attackStrenght = 40
	hp = 125
	monsterName = "Ice Golem"

func _physics_process(delta):
	motion.y += gravity #grawitacja
	if motion.y >= maxGravity:
		motion.y = maxGravity
	
	if goingToPlayer: #kierunek w którym idzie wróg
		if global_position.x - player.global_position.x >= 5:
			goingRight = false
			$Monster1.scale.x = 1
		else:
			goingRight = true
			$Monster1.scale.x = -1
	
	if aggro and !destroyed and player.alive and !shooting:
		if !ladder and is_on_floor() and (global_position.x - player.global_position.x > 10 or global_position.x - player.global_position.x < -10):
			if goingRight:
				if !getBack and !playerInRange: motion.x = 100
				if getBack and playerInRange: motion.x = -100
				if !getBack and playerInRange: $AnimationPlayer.play("idle")
				else: $AnimationPlayer.play("walk")
			if !goingRight: 
				if !getBack and !playerInRange: motion.x = -100
				if getBack and playerInRange: motion.x = 100
				if !getBack and playerInRange: $AnimationPlayer.play("idle")
				else: $AnimationPlayer.play("walk")
		if ladder and ((directionOfLadder and goingRight) or (!directionOfLadder and !goingRight)):
			if waitingForJump and !jumped: motion.x = 0
			if !waitingForJump and is_on_floor(): 
				waitForJump()
				motion.x = 0
		if !waitingForShooting:
			waitingForShooting = true
			waitForShoot()
	
	
	if !aggro and is_on_floor(): motion.x = 0
	
	if jumped:
		if jump < maxJump:
			if goingRight: motion.x = jumpSpeed 
			else: motion.x = -jumpSpeed 
			motion.y = -jumpPower
			jump += jumpPower
		else:
			waitingForJump = false
			jumped = false
	
	if jump == 0:
		motion.x = motion.x / 1.1
	
		if motion.x == 0 and !shooting: $AnimationPlayer.play("idle")
	
	if !aggro and !destroyed and !shooting:
		$AnimationPlayer.play("idle")
	
#	if jump == 0:
#		motion.x = motion.x / 1.001
	
	if is_on_floor():
		jump = 0
	
	if knockbackLength < knockbackMaxLength: #knockback
		if knockbackDirection: motion.x = knockbackStrength
		else: motion.x = -knockbackStrength
		knockbackLength += 1
		modulate = Color(1,0,0)
	else : 
		modulate = Color(1,1,1)
	
	
	if !destroyed: move_and_slide(motion,Vector2(0,-1))

func waitForJump():
	waitingForJump = true
	$Timer2.start(1)
	yield($Timer2,"timeout")
	monsterJump()

func waitForShoot():
	$Timer3.start(2)
	yield($Timer3,"timeout")
	waitingForShooting = false
	shoot()

func shoot():
	shooting = true
	$AnimationPlayer.play("charging")

func shootBullets():
	get_node("/root/MainScene/Player/AnimationPlayerCamera").play("CameraShakingShort")
	
	var b1 = attackBolt.instance()
	var b2 = attackBolt.instance()
	var height = position.y + ($Monster1.texture.get_height() / 2) - (b1.get_child(0).texture.get_height()/2)
	var width = position.x
	b1.shootingMonster = self
	b2.shootingMonster = self
	b1.goingRight = true
	b1.position.y = height
	b1.position.x = width
	b2.scale.x = -1
	b2.position.y = height
	b2.position.x = width
	get_parent().add_child(b2)
	get_parent().add_child(b1)
	b1.timerToDestroy(0.7)
	b2.timerToDestroy(0.7)

func endShoot():
	shooting = false

func monsterJump():
	if player.global_position.y > global_position.y:
		jumped = true
		jump = 1
		jumpSpeed = 250
		maxJump = 1800
		jumpPower = 650
	else:
		jumped = true
		jump = 1
		jumpSpeed = 400
		jumpPower = 800
		maxJump = 2402

func destroyMonster():
	dropGold()
	queue_free()
