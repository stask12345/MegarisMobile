extends monsterClass

var jump = 0 
var jumpPower = 500
var jumpSpeed = 500 # x
var maxJump = 4200
var jumped = false
var waitingForJump = false

func _ready():
	minCoins = 4
	maxCoins = 5
	attackStrenght = 30 #statystyki zmienne
	hp = 70
	monsterName = "Red Slime"

func _physics_process(delta):
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
			print("czeka na skok")
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
		modulate = Color(3,3,3)
	else : 
		modulate = Color(1,1,1)
	
	
	if !destroyed: move_and_slide(motion,Vector2(0,-1))
	

func waitForJump():
	yield(get_tree().create_timer(2), "timeout")
	print("skok")
	jumped = true

func destroyMonster():
	dropGold()
	queue_free()

