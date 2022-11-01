extends monsterClass

var fullLength = 0
var lastSetHp = -1 #Dla lepszej optymalizacji
var maxHp = 0
var attackBolt
onready var playerCamera = get_node("/root/MainScene/Player/AnimationPlayerCamera")
onready var bossHp = get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/BossMenu")
var crystals1
var crystals2
var crystals3
var fightEnd = false

func _ready():
	minCoins = 100
	maxCoins = 200
	attackStrenght = 50 #statystyki zmienne
	hp = 1
	monsterName = "Fallen Emperor"
	fullLength = 820
	triggerTime = 30
	isBossMonster = true
	indestructable = true
	crystals1 = get_node("CrystalHolder/Monster-Crystal1")
	crystals2 = get_node("CrystalHolder/Monster-Crystal2")
	crystals3 = get_node("CrystalHolder/Monster-Crystal3")
	maxHp = 0
	maxHp += crystals1.hp
	maxHp += crystals2.hp
	maxHp += crystals3.hp
	hp = maxHp
	get_node("/root/MainScene/MusicPlayer").playBossTheme()

func _physics_process(_delta):
	var currentHp = 0
	if crystals1 != null and !crystals1.destroyed: currentHp += crystals1.hp 
	else: crystals1 = null
	if crystals2 != null and !crystals2.destroyed: currentHp += crystals2.hp 
	else: crystals2 = null
	if crystals3 != null and !crystals3.destroyed: currentHp += crystals3.hp
	else: crystals3 = null
	
	if lastSetHp != currentHp:
		if currentHp > maxHp: currentHp = maxHp
		var hpPrecent : float = float(currentHp) / float(maxHp)
		if hpPrecent < 0: hpPrecent = 0
		bossHp.get_child(0).scale.x = fullLength * hpPrecent
		lastSetHp = currentHp
		hp = currentHp
	
	
	if aggro: #kierunek w którym idzie wróg
		if global_position.x - player.global_position.x >= 0:
			goingRight = false
		else:
			goingRight = true
	
	
	
	
	if knockbackLength < knockbackMaxLength: #knockback
		knockbackLength += 1
		modulate = Color(3,3,3)
	else : 
		modulate = Color(1,1,1)
	
	if hp <= 0 and !fightEnd:
		fightEnd = true 
		hp = 0
		$AnimationPlayer3.play("deathAnimation")


func destroyMonster():
	get_node("/root/MainScene/Castle/Terrain/BossRoom/AnimationPlayer").play("showLader")
	queue_free()


func playAnimation():
	if player.alive:
		get_node("/root/MainScene/Player/AnimationPlayerCamera").play("cameraShaking")
		$AnimationPlayerDeath.play("BossDeath")

func startIdleAnimation():
	$AnimationPlayer2.play("idle")

func shakeScreen():
	get_node("/root/MainScene/Player/AnimationPlayerCamera").play("cameraShaking")

func fireAttack():
	get_node("/root/MainScene/MusicPlayer").playRumble()
	$AnimationPlayer3.play("fireAttack")

func fireAttack1():
	get_node("/root/MainScene/MusicPlayer").playFireball()
	var b = preload("res://instances/Bullets/FireballContainer1.tscn").instance()
	b.set_global_position(Vector2(player.global_position.x,player.global_position.y-300))
	get_parent().add_child(b)

func fireAttack2():
	get_node("/root/MainScene/MusicPlayer").playFireball()
	var b = preload("res://instances/Bullets/FireballContainer2.tscn").instance()
	b.set_global_position(Vector2(player.global_position.x,player.global_position.y-300))
	get_parent().add_child(b)

func fireAttack3():
	get_node("/root/MainScene/MusicPlayer").playFireball()
	var b = preload("res://instances/Bullets/FireballContainer3.tscn").instance()
	b.set_global_position(Vector2(player.global_position.x-400,-3230))
	get_parent().add_child(b)

func fireAttack4():
	get_node("/root/MainScene/MusicPlayer").playFireball()
	var b = preload("res://instances/Bullets/FireballContainer3.tscn").instance()
	b.set_global_position(Vector2(player.global_position.x+1000,-3230))
	for b1 in b.get_children():
		b1.rotation_degrees = -180
	get_parent().add_child(b)

func fireAttack5():
	get_node("/root/MainScene/MusicPlayer").playFireball()
	var b = preload("res://instances/Bullets/FireballContainer4.tscn").instance()
	b.set_global_position(Vector2(player.global_position.x,player.global_position.y-350))
	get_parent().add_child(b)

func fireAttack6():
	get_node("/root/MainScene/MusicPlayer").playFireball()
	var b = preload("res://instances/Bullets/FireballContainer4.tscn").instance()
	b.set_global_position(Vector2(player.global_position.x,player.global_position.y-350))
	b.scale.x = -1
	get_parent().add_child(b)

func fireAttack7():
	var b = preload("res://instances/Bullets/Monster-bullet-meteor.tscn").instance()
	b.set_global_position(Vector2(player.global_position.x,player.global_position.y-350))
	b.rotation_degrees = 90
	get_parent().add_child(b)

func summonAttack():
	get_node("/root/MainScene/MusicPlayer").playRumble()
	$AnimationPlayer3.play("summonAttack")

func summonAttack1():
	get_node("/root/MainScene/MusicPlayer").playSummon()
	var summonicCircle = preload("res://instances/Bullets/summonerCircle.tscn")
	var s = summonicCircle.instance()
	var s1 = summonicCircle.instance()
	var s2 = summonicCircle.instance()
	var s3 = summonicCircle.instance()
	
	s.position = Vector2(-1380,-3620)
	s1.position = Vector2(1380,-3620)
	s2.position = Vector2(-460,-3400)
	s3.position = Vector2(460,-3400)
	
	get_parent().add_child(s)
	get_parent().add_child(s1)
	get_parent().add_child(s2)
	get_parent().add_child(s3)

func crystalAttack():
	get_node("/root/MainScene/MusicPlayer").playRumble()
	$AnimationPlayer2.play("idle2")
	for c in $CrystalHolder.get_children():
		c.secondStage()

func makePlayerInvisible():
	player.get_node("Area2D").invisible = true
	player.trapped = true

func bossDeath():
	for n in get_node("/root/MainScene/EffectGenerator").get_children():
		if n is monsterClass and n.name != "Monster-Boss2":
			n.queue_free()
	get_node("/root/MainScene/CanvasLayer").makeUIInVisible()
	get_node("/root/MainScene/EffectGenerator").changeBossLabel()
	if bossHp.get_child(0).visible and player.alive:
		playerStats.slayedSecondBoss = 1
		bossHp.get_child(0).visible = false
		bossHp.get_child(1).visible = false
	$AnimationPlayer2.stop()
	get_node("/root/MainScene/Player/Player/Camera2D").global_position = Vector2(0,-3400)

func finalBossDefetedLabel():
	get_node("/root/MainScene/EffectGenerator").finalBossDefeted()

func playRumble():
	get_node("/root/MainScene/MusicPlayer").playRumble()

func playDeflaut():
	get_node("/root/MainScene/MusicPlayer").playDeflautTheme()
