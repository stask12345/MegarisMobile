extends monsterClass

var speed = 10000
var stayInPlaceVar = false
var afterHit = false
var flyToGoal = false

func _ready():
	minCoins = -1
	maxCoins = 0
	attackStrenght = 40 #statystyki zmienne
	hp = 600
	knockbackLength = 9 #knockback
	knockbackMaxLength = 8
	knockbackStrength = 1200
	monsterName = "Magical Crystal"
	indestructable = true
	bossMinion = true
	isBossMonster = true

func _physics_process(delta):
	
	if goingToPlayer: #kierunek w którym idzie wróg
		if global_position.x - player.global_position.x >= 0:
			goingRight = false
		else:
			goingRight = true
	
	if !destroyed:
		if flyToGoal:
			var target = Vector2(-1381,-3620)
			motion = position.direction_to(target) * speed * delta
			motion = move_and_slide(motion)
			if position.distance_to(target) < 2: 
				flyToGoal = false
				thirdStage()
	
	if knockbackLength < knockbackMaxLength: #knockback
		knockbackLength += 1
		modulate = Color(1,0,0)
	else : 
		modulate = Color(1,1,1)
	
	if hp <= 0: get_node("/root/MainScene/EffectGenerator/Monster-Boss2").crystals1 = null

func secondStage():
	rotation_degrees = 0
	var g = global_position
	var pp = get_parent().get_parent().get_parent()
	get_parent().remove_child(self)
	pp.add_child(self)
	global_position = g
	flyToGoal = true

func thirdStage():
	indestructable = false
	$AnimationPlayer.play("idleShooting")

func destroyMonster():
	get_node("/root/MainScene/EffectGenerator/Monster-Boss2").crystals1 = null
	queue_free()

func _on_TriggerArea_body_entered(body):
	if body.name == "Player":
		goingToPlayer = true
		aggro = true

func _on_TriggerArea_body_exited(body):
	if body.name == "Player":
		loseTriggerOnPlayer()
