extends Sprite

onready var joystickWepon = get_parent().get_parent().get_node("CanvasLayer/Control2/JoystickAttack/TouchScreenButton")
onready var player = get_parent().get_node("Player")
onready var playerMovement = get_parent().get_parent().get_node("Player")
onready var animationPlayer = get_parent().get_node("AnimationPlayerWepon")
onready var spriteOfWepon = get_child(0).get_child(0)
onready var weponHolder = get_parent().get_parent().get_node("CanvasLayer/Control4/WeponHolder")
var bulletSword = preload("res://instances/Bullets/sworldBullet.tscn")
var bulletSwordDouble = preload("res://instances/Bullets/sworldBulletDouble.tscn")
var bulletSwordDemonic = preload("res://instances/Bullets/swordBulletDemonic.tscn")
var bulletSlash = preload("res://instances/Bullets/slashBullet.tscn")
var bulletExplosion = preload("res://instances/Bullets/explosionBullet.tscn")
var bulletArrow = preload("res://instances/Bullets/arrowBullet.tscn")
var bulletArrowDouble = preload("res://instances/Bullets/DoubleBowBullet.tscn")
var bulletMagic = preload("res://instances/Bullets/magicBullet.tscn")
var bulletMagic2 = preload("res://instances/Bullets/magicBullet2.tscn")
var bulletMagic3 = preload("res://instances/Bullets/magicBullet3.tscn")
var bulletMagic4 = preload("res://instances/Bullets/laserBullet.tscn")
var bulletSpecial4 = preload("res://instances/Bullets/summonerBullet.tscn")
var bulletSpecial3 = preload("res://instances/Bullets/summonerBulletFire.tscn")#3 lepsza niz 4
var bulletSpecial2 = preload("res://instances/Bullets/DoubleSwordAxeBullet.tscn")
var bulletSpear = preload("res://instances/Bullets/spearBullet.tscn")
var bulletSpearDouble = preload("res://instances/Bullets/spearDoubleBullet.tscn")
var fireRate = 0 #ustawiane w ready
var can_fire = true


func _process(delta):
	var rotationOfWepon = joystickWepon.get_value_rotation()#obracanie bronią
	if rotationOfWepon == 0:
		if player.scale.x == 1: 
			scale.x = 1
		else:
			scale.x = -1
	if rotationOfWepon < -90: 
		scale.x = -1
		rotationOfWepon -= 180 #180
		if !playerMovement.running: player.scale.x = -1
	else: 
		if rotationOfWepon < 0:
			scale.x = 1
			if !playerMovement.running: player.scale.x = 1
	if rotationOfWepon > 90:
		if !playerMovement.running: player.scale.x = -1
		scale.x = -1 
		rotationOfWepon += 180
	else: 
		if rotationOfWepon > 0:
			if !playerMovement.running:player.scale.x = 1
			scale.x = 1

	rotation_degrees = rotationOfWepon
	
	if  get_parent().alive and weponHolder.get_child_count() > 0 and can_fire and (joystickWepon.get_value_attack().x > 0.7 or joystickWepon.get_value_attack().x < -0.7 or joystickWepon.get_value_attack().y > 0.7 or joystickWepon.get_value_attack().y < -0.7):
		can_fire = false
		shot()
		var wepon = get_parent().get_parent().get_node("CanvasLayer/Control4/WeponHolder").get_child(0)
		yield(get_tree().create_timer(wepon.fireSpeed),"timeout")
		can_fire = true

func shot():
	var wepon = get_node("/root/MainScene/CanvasLayer/Control4/WeponHolder").get_child(0)
	var shot
	if wepon.typeOfBullet == "slash": shot = bulletSlash.instance()
	if wepon.typeOfBullet == "sword": shot = bulletSword.instance()
	if wepon.typeOfBullet == "slash and sword": shot = bulletSpecial2.instance()
	if wepon.typeOfBullet == "explosion": shot = bulletExplosion.instance()
	if wepon.typeOfBullet == "sword double": shot = bulletSwordDouble.instance()
	if wepon.typeOfBullet == "sword demonic": shot = bulletSwordDemonic.instance()
	if wepon.typeOfBullet == "pircing": shot = bulletSpear.instance()
	if wepon.typeOfBullet == "pircing double": shot = bulletSpearDouble.instance()
	if wepon.typeOfBullet == "arrow": shot = bulletArrow.instance()
	if wepon.typeOfBullet == "arrow double": shot = bulletArrowDouble.instance()
	if wepon.typeOfBullet == "magic": shot = bulletMagic.instance()
	if wepon.typeOfBullet == "magic2": shot = bulletMagic2.instance()
	if wepon.typeOfBullet == "magic3": shot = bulletMagic3.instance()
	if wepon.typeOfBullet == "magic4": shot = bulletMagic4.instance()
	if wepon.typeOfBullet == "special4": shot = bulletSpecial4.instance()
	if wepon.typeOfBullet == "special3": shot = bulletSpecial3.instance()
	if scale.x == -1:
		 shot.scale.x = -1
	shot.set_rotation(rotation)
	shot.set_position(Vector2(40,0))
	animationPlayer.play("swordSwing")
	if wepon.textureChangeAfterShot == true: wepon.changeGraphic() 
	add_child(shot) 

func get_wepon():
	if get_node("/root/MainScene/Player/WeponHolder/swordRotation/spriteOfWepon").texture.resource_path != "res://grafika/white.png": return get_node("/root/MainScene/Player/WeponHolder/swordRotation/spriteOfWepon")
	if get_node("/root/MainScene/Player/WeponHolder/bowRotation/spriteOfWepon").texture.resource_path != "res://grafika/white.png": return get_node("/root/MainScene/Player/WeponHolder/bowRotation/spriteOfWepon")
	if get_node("/root/MainScene/Player/WeponHolder/spearRotation/spriteOfWepon").texture.resource_path != "res://grafika/white.png": return get_node("/root/MainScene/Player/WeponHolder/spearRotation/spriteOfWepon")
	return null
