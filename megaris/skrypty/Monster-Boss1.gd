extends monsterClass

var jump = 0 
var jumpPower = 700
var jumpSpeed = 250 # x
var maxJump = 12000
var fullLength = 0
var lastSetHp = -1 #Dla lepszej optymalizacji
var maxHp = 0
var jumped = false
var waitingForJump = false
var attackBolt = preload("res://instances/Bullets/Sliding-monster-bullet.tscn")
var smallBlueSlime = preload("res://instances/Monsters/Monster-SmallBlueSlime.tscn")
onready var playerCamera = get_node("/root/MainScene/Player/AnimationPlayerCamera")
onready var bossHp = get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/BossMenu")

func _ready():
	minCoins = 100
	maxCoins = 200
	attackStrenght = 30 #statystyki zmienne
	hp = 65
	gravity = 50
	maxGravity = 660
	monsterName = "Slime King"
	fullLength = bossHp.get_child(0).scale.x
	maxHp = hp

func _physics_process(delta):
	if lastSetHp != hp:
		if hp > maxHp: hp = maxHp
		var hpPrecent : float = float(hp) / float(maxHp)
		if hpPrecent < 0: hpPrecent = 0
		print(fullLength)
		print(hpPrecent)
		print(hp)
		print(maxHp)
		bossHp.get_child(0).scale.x = fullLength * hpPrecent
		lastSetHp = hp
	
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
	$Timer2.start(2)
	yield($Timer2,"timeout")
	$AnimationPlayer.play("jumping")
	$Timer3.start(1)
	yield($Timer3,"timeout")
	jumped = true
	jump = 1


func destroyMonster():
	bossHp.visible = false
	get_node("/root/MainScene/EffectGenerator/AnimationPlayer").play("teleportToCastle")
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
	get_node("/root/MainScene/Player/AnimationPlayerCamera").play("cameraShaking")
	$AnimationPlayerDeath.play("BossDeath")

func addSlimes():
	var slime = preload("res://instances/Monsters/Monster-Slime.tscn")
	for n in 2:
		var addSlime = slime.instance()
		addSlime.position = Vector2(rand_range(-1600,1600),-4000)
		get_node("/root/MainScene").add_child(addSlime)
		n += 1
