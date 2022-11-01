extends Sprite

var hp : float = 100
var maxHp : float = 100
var fullLength = 0
var lastSetHp = -1 #Dla lepszej optymalizacji
var dead = false
onready var effectGenerator = get_node("/root/MainScene/EffectGenerator")
onready var player = get_node("/root/MainScene/Player")

func _ready():
	fullLength = scale.x

func _process(_delta): # ! Do usprawnienia to nie musi koniecznie się wykonywać co sekunde !
	if lastSetHp != hp:
		if maxHp > get_parent().maxHpAcquired: get_parent().maxHpAcquired = maxHp
		if hp > maxHp: hp = maxHp
		var hpPrecent : float = hp / maxHp
		if hpPrecent < 0: hpPrecent = 0
		get_parent().get_node("HpLabel").text = String(hp) + "/" + String(maxHp)
		scale.x = fullLength * hpPrecent
		if (hpPrecent > 0.7): self_modulate = Color.seagreen
		else: if (hpPrecent > 0.4): self_modulate = Color.yellow
		else: self_modulate = Color.red
		lastSetHp = hp
	
	if hp <= 0 and !dead:
		dead = true
		effectGenerator.deathAnimation()
	
	if Input.is_key_pressed(16777351):
		maxHp += 1000
		hp += 1000

func dealDamagePlayer(var value):
	if player.get_node("Area2D").invisible == false:
		var damage = value - (get_parent().levelOfArmor * 5) - get_parent().armorIncrease
		if damage < 0: damage = 0
		hp -= damage
		var damageLabelPosition = player.global_position
		damageLabelPosition.y -= 40
		effectGenerator.generateDamageLabel(damageLabelPosition,damage,true)

func saveCurrent():
	var node_data = {
		"type": "normal",
		"hp": hp,
		"maxHp": maxHp,
		"nodePath": get_path()
	}
	return node_data
