extends monsterClass

var jump = 0 
var jumpPower = 600
var jumpSpeed = 600 # x
var maxJump = 4500
var jumped = false
var waitingForJump = false

func _ready():
	minCoins = 2
	maxCoins = 4
	attackStrenght = 40 #statystyki zmienne
	hp = 85
	monsterName = "Purple Slime"
	isSlimeMonster = true
	dropped = true

func _physics_process(delta):
	if get_parent().visible == true:
		if motion.y < maxGravity:
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
			dropped = false
			if jump != 0 and jump > jumpPower+1:
				get_node("/root/MainScene/MusicPlayer").playSlime()
			jump = 0
			motion.x = 0
		
		if knockbackLength < knockbackMaxLength: #knockback
			if knockbackDirection: motion.x = knockbackStrength
			else: motion.x = -knockbackStrength
			knockbackLength += 1
			modulate = Color(1,0,0)
		else : 
			modulate = Color(1,1,1)
		
		
		if !destroyed:
			if motion.x != 0 or motion.y != maxGravity or dropped:
				 move_and_slide(motion,Vector2(0,-1))
		


func waitForJump():
	$Timer2.start(2)
	yield($Timer2, "timeout")
	jumped = true


func destroyMonster():
	dropGold()
	queue_free()
