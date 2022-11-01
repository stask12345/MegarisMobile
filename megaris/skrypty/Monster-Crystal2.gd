extends monsterClass

var speed = 7000
var stayInPlaceVar = false
var afterHit = false
var aggroC = false

func _ready():
	minCoins = -1
	maxCoins = 0
	attackStrenght = 50 #statystyki zmienne
	hp = 1000
	knockbackLength = 9 #knockback
	knockbackMaxLength = 8
	knockbackStrength = 1200
	monsterName = "Magical Crystal"
	indestructable = true
	bossMinion = true

func _physics_process(delta):
	if global_position.x - player.global_position.x >= 0:
		goingRight = false
	else:
		goingRight = true
	
	
	if !destroyed and aggroC:
		look_at(player.position)
		var target = player.position
		motion = position.direction_to(target) * speed * delta
		if position.distance_to(target) > 5:
			motion = move_and_slide(motion)
	
	if knockbackLength < knockbackMaxLength: #knockback
		knockbackLength += 1
		modulate = Color(1,0,0)
	else:
		modulate = Color(1,1,1)
	
	if hp <= 0: get_node("/root/MainScene/EffectGenerator/Monster-Boss2").crystals3 = null

func secondStage():
	indestructable = false
	rotation_degrees = 0
	var g = global_position
	var pp = get_parent().get_parent().get_parent()
	get_parent().remove_child(self)
	pp.add_child(self)
	global_position = g
	aggroC = true
	$AnimationPlayer.play("idleShooting")

func destroyMonster():
	get_node("/root/MainScene/EffectGenerator/Monster-Boss2").crystals3 = null
	queue_free()

func _on_TriggerArea_body_entered(body):
	if body.name == "Player":
		goingToPlayer = true
		aggro = true

func _on_TriggerArea_body_exited(body):
	if body.name == "Player":
		loseTriggerOnPlayer()
