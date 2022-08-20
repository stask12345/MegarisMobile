extends monsterClass

var lastSetHp

func _ready():
	hp = 40
	lastSetHp = hp

func _process(delta):
	if lastSetHp != hp and !destroyed:
		lastSetHp = hp
		if global_position.x - player.global_position.x >= 0:
			goingRight = false
		else:
			goingRight = true
		if goingRight: $AnimationPlayer.play("leftAttack")
		else: $AnimationPlayer.play("rightAttack")

func destroyMonster():
	get_parent().dummyDestroyed = true
