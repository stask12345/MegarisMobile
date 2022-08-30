extends monsterClass

var speed = 12000
var stayInPlaceVar = false
var afterHit = false

func _init(): #by przyznawało wartość zmiennej przed ładowaniem w scene #wymagane przy generowaniu mobów
	flying = true

func _ready():
	knockbackLength = 9 #knockback
	knockbackMaxLength = 8
	knockbackStrength = 1200
	attackStrenght = 35 #statystyki zmienne
	hp = 80
	minCoins = 2
	maxCoins = 4
	monsterName = "Monstrous Bat"

func _physics_process(delta):
	
	if goingToPlayer: #kierunek w którym idzie wróg
		if global_position.x - player.global_position.x >= 0:
			goingRight = false
		else:
			goingRight = true
		
	
	if knockbackLength < knockbackMaxLength: #knockback
		if knockbackDirection: motion.x = knockbackStrength
		else: motion.x = -knockbackStrength
		knockbackLength += 1
		modulate = Color(1,0,0)
	else : 
		modulate = Color(1,1,1)
	
	if !destroyed and aggro:
		var target = player.position
		target.y -= 10 #robie to bo chce by przecienik by na poziomie glowy
		motion = position.direction_to(target) * speed * delta
		
		if knockbackLength < knockbackMaxLength:
			if knockbackDirection: motion.x += knockbackStrength
			else: motion.x += -knockbackStrength
			if knockbackDirection: 
				motion.y += -knockbackStrength
			else: 
				motion.y += -knockbackStrength
			knockbackLength += 1
			modulate = Color(1,0,0)
		else:
			modulate = Color(1,1,1)
		
		if position.distance_to(target) > 5 and (!stayInPlaceVar or knockbackLength < knockbackMaxLength):
			if !afterHit: motion = move_and_slide(motion)
			else: 
				motion.y -= 50
				if knockbackDirection: motion.x -= (50 + (player.position - position).length()/3)
				else: motion.x += ( 50 + (player.position - position).length()/3)
				motion = move_and_slide(motion)


func afterHitFlaying(): #ta funkcja jest wywoływana z player hitboxa 
	yield(get_tree().create_timer(0.1), "timeout")
	afterHit = true
	yield(get_tree().create_timer(0.3), "timeout")
	afterHit = false

func stayInPlace():
	stayInPlaceVar = true
	yield(get_tree().create_timer(0.3), "timeout")
	stayInPlaceVar = false

func destroyMonster():
	dropGold()
	queue_free()


func _on_TriggerArea_body_entered(body):
	if body.name == "Player":
		goingToPlayer = true
		aggro = true

func _on_TriggerArea_body_exited(body):
	if body.name == "Player":
		loseTriggerOnPlayer()


