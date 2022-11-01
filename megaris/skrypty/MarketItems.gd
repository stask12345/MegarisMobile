extends Sprite

onready var EffectGenerator = get_node("/root/MainScene/EffectGenerator")
var sword2 = preload("res://instances/Wepons/Sword2.tscn")
var spear1 = preload("res://instances/Wepons/Spear1.tscn")
var mace1 = preload("res://instances/Wepons/Mace1.tscn")
var bow1 = preload("res://instances/Wepons/Bow1.tscn")
var wand1 = preload("res://instances/Wepons/Wand1.tscn")
var healingPotion2 = preload("res://instances/Items/PotionHealing2.tscn")
var healingPotion3 = preload("res://instances/Items/PotionHealing3.tscn")
var healthPotion = preload("res://instances/Items/PotionHealth1.tscn")
var invisibilityPotion = preload("res://instances/Items/PotionInvisibility1.tscn")
var StrengthPotion = preload("res://instances/Items/PotionStrength1.tscn")
var special1 = preload("res://instances/Wepons/SpecialWand4.tscn")
var special2 = preload("res://instances/Wepons/SpecialSword2.tscn")
var scroolExplosion1 = preload("res://instances/Items/SpellExplosion.tscn")
var scroolFireBall1 = preload("res://instances/Items/SpellFireBall.tscn")

var special3 = preload("res://instances/Wepons/SpecialWand3.tscn")
var special4 = preload("res://instances/Wepons/SpecialSword1.tscn")
var scroolExplosion2 = preload("res://instances/Items/SpellExplosion1.tscn")
var scroolFireBall2 = preload("res://instances/Items/SpellFireBall1.tscn")
var sword3 = preload("res://instances/Wepons/Sword4.tscn")
var spear3 = preload("res://instances/Wepons/Spear3.tscn")
var mace3 = preload("res://instances/Wepons/Mace3.tscn")
var wand3 = preload("res://instances/Wepons/Wand3.tscn")
var bow3 = preload("res://instances/Wepons/Bow3.tscn")
var healingPotion4 = preload("res://instances/Items/PotionHealing4.tscn")
var healthPotion1 = preload("res://instances/Items/PotionHealth2.tscn")
var invisibilityPotion1 = preload("res://instances/Items/PotionInvisibility2.tscn")
var StrengthPotion1 = preload("res://instances/Items/PotionStrength2.tscn")

var itemList1 = [special1,special2,scroolExplosion1,scroolExplosion1,scroolFireBall1,scroolFireBall1,sword2,spear1,mace1,bow1,wand1,healingPotion2,healingPotion2,healingPotion3,healingPotion3,healthPotion,invisibilityPotion,StrengthPotion]
var itemList2 = [special3,special4,scroolExplosion2,scroolExplosion2,scroolFireBall2,scroolFireBall2,sword3,spear3,mace3,bow3,wand3,healingPotion3,healingPotion3,healingPotion4,healthPotion1,invisibilityPotion1,StrengthPotion1]

func _ready():
	pass

func placeSkills():
	
	var itemList
	if EffectGenerator.atCastle != "castle": itemList = itemList1
	else: itemList = itemList2
	
	var i = randi()%itemList.size()
	var i1 = itemList[i].instance()
	get_node("/root/MainScene/Floor/ItemMarket/Market/SkillTable/KinematicBody2D2").add_child(i1)
	get_node("SkillTable").skillInScript = i1
	get_node("SkillTable")._readyItem()
	itemList.remove(i)
	
	i = randi()%itemList.size()
	var i2 = itemList[i].instance()
	get_node("/root/MainScene/Floor/ItemMarket/Market/SkillTable2/KinematicBody2D2").add_child(i2)
	get_node("SkillTable2").skillInScript = i2
	get_node("SkillTable2")._readyItem()
	itemList.remove(i)
	
	i = randi()%itemList.size()
	var i3 = itemList[i].instance()
	get_node("/root/MainScene/Floor/ItemMarket/Market/SkillTable3/KinematicBody2D2").add_child(i3)
	get_node("SkillTable3").skillInScript = i3
	get_node("SkillTable3")._readyItem()
	itemList.remove(i)
	
	makeTablesEmpty()

func makeTablesEmpty():
	if get_node("SkillTable/KinematicBody2D2").get_child_count() == 0:
		get_node("SkillTable/Label").visible = false
		get_node("SkillTable/Area2D/CollisionShape2D").disabled = true
	if get_node("SkillTable2/KinematicBody2D2").get_child_count() == 0:
		get_node("SkillTable2/Label").visible = false
		get_node("SkillTable2/Area2D/CollisionShape2D").disabled = true
	if get_node("SkillTable3/KinematicBody2D2").get_child_count() == 0:
		get_node("SkillTable3/Label").visible = false
		get_node("SkillTable3/Area2D/CollisionShape2D").disabled = true

func clearTables():
	if get_node("SkillTable/KinematicBody2D2").get_child_count() != 0:
		get_node("SkillTable/KinematicBody2D2").get_child(0).queue_free()
	if get_node("SkillTable2/KinematicBody2D2").get_child_count() != 0:
		get_node("SkillTable2/KinematicBody2D2").get_child(0).queue_free()
	if get_node("SkillTable3/KinematicBody2D2").get_child_count() != 0:
		get_node("SkillTable3/KinematicBody2D2").get_child(0).queue_free()
	
	get_node("SkillTable/Area2D/CollisionShape2D").disabled = false
	get_node("SkillTable2/Area2D/CollisionShape2D").disabled = false
	get_node("SkillTable3/Area2D/CollisionShape2D").disabled = false
	
	yield(get_tree().create_timer(0.1), "timeout")
	placeSkills()
