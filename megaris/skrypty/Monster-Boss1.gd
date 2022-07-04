extends monsterClass

var jump = 0 
var jumpPower = 700
var jumpSpeed = 250 # x
var maxJump = 12000
var jumped = false
var waitingForJump = false
var attackBolt = preload("res://instances/Bullets/Sliding-monster-bullet.tscn")
var smallBlueSlime = preload("res://instances/Monsters/Monster-SmallBlueSlime.tscn")
onready var playerCamera = get_node("/root/MainScene/Player/AnimationPlayerCamera")

func _ready():
	minCoins = 4
	maxCoins = 5
	attackStrenght = 30 #statystyki zmienne
	hp = 65
	gravity = 50
	maxGravity = 660
	monsterName = "Gigantic Slime"

func _physics_process(delta):
	motion.y += gravity #grawitacja
	if motion.y >= maxGravity:
		motion.y = maxGravity
	if motion.y > 0: motion.y = motion.y * 1.1
	
	if aggro and jump == 0: #kierunek w którym idzie wróg
		if global_position.x - player.global_position.x >= 0:
			goingRight = false
		else:
			goingRight = true
		if !waitingForJump and is_on_floor() and !destroyed: #czekanie pomiędzy skokami
			waitingForJump = true
			waitForJump()
	
	if jump == 0:
		motion.x = motion.x / 1.1
	
	if !destroyed and jumped and (!is_on_floor() or jump != 0):
		if jump < maxJump:
			$AnimationPlayer.play("flying")
			if goingRight: motion.x = jumpSpeed 
			else: motion.x = -jumpSpeed 
			motion.y = -jumpPower
			jump += jumpPower
		else:
#			$AnimationPlayer.play("falling")
			waitingForJump = false
			jumped = false
	
	if is_on_floor():
		if jump != 0 and jump > jumpPower+1:
			shootBullets()
			$AnimationPlayer.play("idle")
			addSlimes()
			playerCamera.play("CameraShakingShort")
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
	else: move_and_slide(Vector2(0,motion.y),Vector2(0,-1))
	

func waitForJump():
	yield(get_tree().create_timer(1), "timeout")
	$AnimationPlayer.play("jumping")
	yield(get_tree().create_timer(2), "timeout")
	jumped = true
	jump = 1


func destroyMonster():
	dropGold()
	var slime1 = smallBlueSlime.instance()
	var slime2 = smallBlueSlime.instance()
	slime1.position = position
	slime2.position = position
	slime1.position.x -= 30
	slime2.position.x += 30
	get_parent().add_child(slime1)
	get_parent().add_child(slime2)
	queue_free()

func shootBullets():
	var b1 = attackBolt.instance()
	var b2 = attackBolt.instance()
	b1.scale.x = 2
	b1.scale.y = 2
	b2.scale.x = 2
	b2.scale.y = 2
	var height = position.y + ($Monster1.texture.get_height() / 3) - (b1.get_child(0).texture.get_height()) + 1
	var width = position.x
	b1.shootingMonster = self
	b2.shootingMonster = self
	b1.goingRight = true
	b1.position.y = height
	b1.position.x = width
	b2.scale.x = -2
	b2.position.y = height
	b2.position.x = width
	get_parent().add_child(b2)
	get_parent().add_child(b1)
	b1.timerToDestroy(1.2)
	b2.timerToDestroy(1.2)

func playAnimation():
	$AnimationPlayerDeath.play("BossDeath")

func addSlimes():
	var slime = preload("res://instances/Monsters/Monster-Slime.tscn")
	for n in 2:
		var addSlime = slime.instance()
		addSlime.position = Vector2(rand_range(-1600,1600),-4000)
		get_node("/root/MainScene").add_child(addSlime)
		n += 1
