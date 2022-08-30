extends monsterClass

var jump = 0 
var jumpPower = 650
var jumpSpeed = 210 # x
var maxJump = 1800
var jumped = false
var ladder = false
var waitingForJump = false
var directionOfLadder = false

func _ready():
	minCoins = 1
	maxCoins = 3
	attackStrenght = 25
	hp = 70
	monsterName = "Cave Turtle"

func _physics_process(_delta):
	motion.y += gravity #grawitacja
	if motion.y >= maxGravity:
		motion.y = maxGravity
	
	if goingToPlayer or aggro: #kierunek w którym idzie wróg
		if global_position.x - player.global_position.x >= 5:
			goingRight = false
			$Monster1.scale.x = -1
		else:
			goingRight = true
			$Monster1.scale.x = 1
	
	if aggro and !destroyed and player.alive:
		if !ladder and is_on_floor() and (global_position.x - player.global_position.x > 10 or global_position.x - player.global_position.x < -10):
			if goingRight:
				motion.x = 100
				$AnimationPlayer.play("walk")
			if !goingRight: 
				motion.x = -100
				$AnimationPlayer.play("walk")
		if ladder and ((directionOfLadder and goingRight) or (!directionOfLadder and !goingRight)):
			if waitingForJump and !jumped: motion.x = 0
			if !waitingForJump and is_on_floor(): 
				waitForJump()
				motion.x = 0
	
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
	
		if motion.x == 0 and !destroyed: $AnimationPlayer.play("idle")
	
	if !aggro and !destroyed:
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
