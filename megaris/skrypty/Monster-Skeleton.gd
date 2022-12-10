extends monsterClass

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
	minCoins = 3
	maxCoins = 5
	attackStrenght = 40
	hp = 110
	monsterName = "Skeleton Swordman"
	isSkeletonMonster = true
	dropped = true

func _physics_process(delta):
	if get_parent().visible == true:
		if !$AnimationPlayer.is_playing(): $AnimationPlayer.play("idle")
		
		if motion.y < maxGravity:
			motion.y += gravity #grawitacja
			if motion.y >= maxGravity:
				motion.y = maxGravity
		
		if (goingToPlayer or aggro) and !shooting: #kierunek w którym idzie wróg
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
		
			if motion.x == 0 and !shooting and !destroyed: $AnimationPlayer.play("idle")
		
		if !aggro and !destroyed and !shooting:
			$AnimationPlayer.play("idle")
		
		
		if is_on_floor():
			dropped = false
			jump = 0
		
		if knockbackLength < knockbackMaxLength: #knockback
			if knockbackDirection: motion.x = knockbackStrength
			else: motion.x = -knockbackStrength
			knockbackLength += 1
			modulate = Color(1,0,0)
		else : 
			modulate = Color(1,1,1)
		
		if shooting and !destroyed:
			$Monster1.frame = 4
			if goingRight: motion.x = 400
			else: motion.x = -400
		
		if !destroyed:
			if motion.x != 0 or motion.y != maxGravity or dropped:
				 move_and_slide(motion,Vector2(0,-1))

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
	var musicPlayer = get_node("/root/MainScene/CanvasLayer/Control4/GameMenu")
	if musicPlayer.sound: $SoundEffectCharge.play()
	shooting = true
	indestructable = true
	$Monster1.self_modulate = Color.blue
	maxGravity = 0
	$Timer4.start(0.5)
	yield($Timer4,"timeout")
	$Monster1.self_modulate = Color(1,1,1,1)
	maxGravity = 800
	indestructable = false
	shooting = false


func monsterJump():
	if player.global_position.y - 10 > global_position.y:
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
