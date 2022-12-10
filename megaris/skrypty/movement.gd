extends KinematicBody2D

onready var joystickScript = get_parent().get_node("CanvasLayer/Control/Joystick/TouchScreenButton")
var motion = Vector2()
var speed = 26000 
var gravity = 80 #przy zmianach, zmień też sekcje "poruszanie na drabinie" 
var maxGravity = 800
var jump = 0 
var jumpPower = 1300
var maxJump = 9000
var jumped = false
var previousMotion #do spadania w łuku
var canJump = true #by trzeba było wracac joystickiem po kazdym skoku
var onLadder = false #wykorzystywane tylko w skypcie drabiny
var running = false
var knockbackLength = 4
var knockbackMaxLength = 3
var knockbackStrength = 1
var knockbackDirection = false
var hpDelay = false
var trapped = true
var stuck = false #jak trapped ale nie więzi w y
var redColor = false
var alive = true
var playerVisible = false
var falling = false
var playMusic = false

func _ready():
	$Player.visible = false


func _physics_process(delta):
	
	
	if alive == true:
		#poruszanie na drabinie
		if onLadder and !trapped:
			if joystickScript.get_value().x == 0: motion.x = 0
			if joystickScript.get_value().y == 0: motion.y = 0
			$Player.visible = false
			$PlayerCliming.visible = true
			if joystickScript.get_value().y < -0.2 or joystickScript.get_value().y > 0.2:
				if joystickScript.get_value().y < -0.2: $AnimationPlayerCliming.play("playerCliming")
				else: $AnimationPlayerCliming.play("PlayerClimingDown")
			else: $AnimationPlayerCliming.stop(false)
			maxJump = 99999999
			canJump = true
			jumped = false
			gravity = 0
			jumpPower = 200 #Te wartości później są przywracane w skrypcie drabiny
		else:
			if playerVisible: $Player.visible = true
			$PlayerCliming.visible = false
		
		#animacja
		if joystickScript.get_value().x > 0.01: $Player.scale.x = 1
		if joystickScript.get_value().x < -0.01: $Player.scale.x = -1
		
		if joystickScript.get_value().y > -0.2: canJump = true
		
		if is_on_floor():
			if joystickScript.get_value().x > 0.01 or joystickScript.get_value().x < -0.01:
				$AnimationPlayer.play("running_right")
			else: 
				$AnimationPlayer.play("idle_right")
				
		else: 
			if joystickScript.get_value().y < -0.2 or falling:
				if motion.y < 0: $AnimationPlayer.play("jump")
				else:  $AnimationPlayer.play("fall")
		
		if joystickScript.get_value().x > 0.1 or joystickScript.get_value().x < -0.1: running = true
		else: running = false
		
		if !is_on_floor() and joystickScript.get_value().x == 0 and motion.x != 0:
			motion.x = previousMotion.x / 1.005 #spadanie spowodne
		else:
			if knockbackLength < knockbackMaxLength: #knockback
				if knockbackDirection: motion.x = knockbackStrength
				else: motion.x = -knockbackStrength
				knockbackLength += 1
				changeColor(Color.red)
			else : 
				motion.x = joystickScript.get_value().x #normalne poruszanie się
				if !redColor: changeColor(Color.white)
		if jump < maxJump and (joystickScript.get_value().y < -0.2 or onLadder) and !jumped and (canJump or !is_on_floor()):
			canJump = false
			motion.y = joystickScript.get_value().y * jumpPower
			jump -= jumpPower * joystickScript.get_value().y 
			if joystickScript.get_value().y > -0.4: jump += jumpPower
		else:
			if !is_on_floor(): 
				jumped = true
		motion.y += gravity
		if motion.y >= maxGravity:
			motion.y = maxGravity
		previousMotion = motion
		motion.x = motion.x * speed * delta
		if !trapped and !stuck: motion = move_and_slide(motion, Vector2(0,-1)) #ten 2 vector określa gdzie jest góra dla is on floor
		if stuck: move_and_slide(Vector2(0,motion.y), Vector2(0,-1)) #Do walki z bossem 
		if is_on_floor(): 
			if jump > 6000:
				if playMusic: $SoundEffectLand.play()
			if jump > 9950 and !running:
				jump = 0
				$AnimationPlayerJumpEffect.play("jumpEffect")
			jump = 0
			jumped = false

func get_knock(direction,bossHit = false): #knockback z obrażeń #direction ture - prawo #wiecej ustawien w skrypcie u góry
	if bossHit:
		knockbackMaxLength = 7
		knockbackStrength = 2
	else:
		knockbackMaxLength = 3
		knockbackStrength = 1
	knockbackLength = 0
	knockbackDirection = direction
	motion.y -= 300

func get_damage_without_knockback():
	if !get_node("Area2D").invisible:
		redColor = true
		modulate = Color(1,0,0)
		yield(get_tree().create_timer(0.2), "timeout")
		redColor = false
		modulate = Color(1,1,1)

func hpDelayTimer():
	yield(get_tree().create_timer(0.2), "timeout") #może generować problemy
	hpDelay = false

func changeColor(color, instant=false):
	if !instant:
		modulate = color
	if instant:
		if color == Color.green: $AnimationPlayerColor.play("colorGreen")
		if color == Color.blue: $AnimationPlayerColor.play("colorBlue")
		if color == Color.red: $AnimationPlayerColor.play("colorRed")

func saveCurrent():
	var node_data
	if get_node("/root/MainScene/EffectGenerator").atCastle != "rewardRoom":
		node_data = {
			"type": "player",
			"pos_x": position.x,
			"pos_y": position.y,
			"nodePath": get_path()
		}
	else: #Po podniesieniu skilla, gdy castle jeszcze nie załadowany
		node_data = {
			"type": "player",
			"pos_x": -122,
			"pos_y": 904,
			"nodePath": get_path()
		}
	return node_data
