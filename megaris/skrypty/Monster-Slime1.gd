extends monsterClass

var jump = 0 
var jumpPower = 400
var jumpSpeed = 400 # x
var maxJump = 3600
var jumped = false
var waitingForJump = false

func _ready():
	minCoins = -1
	maxCoins = 1
	attackStrenght = 20 #statystyki zmienne
	hp = 10
	monsterName = "Green Slime"
	isSlimeMonster = true

func _physics_process(_delta):
	motion.y += gravity #grawitacja
	if motion.y >= maxGravity:
		motion.y = maxGravity
	
	if aggro and jump == 0: #kierunek w którym idzie wróg
		if global_position.x - player.global_position.x >= 0:
			goingRight = false
		else:
			goingRight = true
		if !waitingForJump and is_on_floor(): #czekanie pomiędzy skokami
			waitingForJump = true
			waitForJump()
	
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
	
	if is_on_floor():
		jump = 0
		motion.x = 0
	
	if knockbackLength < knockbackMaxLength: #knockback
		if knockbackDirection: motion.x = knockbackStrength
		else: motion.x = -knockbackStrength
		knockbackLength += 1
		modulate = Color(1,0,0)
	else : 
		modulate = Color(1,1,1)
	
	
	if !destroyed: move_and_slide(motion,Vector2(0,-1))
	

func waitForJump():
	$Timer2.start(2)
	yield($Timer2, "timeout")
	jumped = true


func destroyMonster():
	dropGold()
	queue_free()
