extends Sprite

onready var EffectGenerator = get_node("/root/MainScene/EffectGenerator")
var sword2 = preload("res://instances/Wepons/Sword2.tscn")
var spear1 = preload("res://instances/Wepons/Spear1.tscn")
var mace1 = preload("res://instances/Wepons/Mace0.tscn")
var bow1 = preload("res://instances/Wepons/Bow1.tscn")
var wand1 = preload("res://instances/Wepons/Wand1.tscn")
var healingPotion2 = preload("res://instances/Items/PotionHealing2.tscn")
var healingPotion3 = preload("res://instances/Items/PotionHealing3.tscn")
var healthPotion = preload("res://instances/Items/PotionHealth1.tscn")
var invisibilityPotion = preload("res://instances/Items/PotionInvisibility1.tscn")
var StrengthPotion = preload("res://instances/Items/PotionStrength1.tscn")

var itemList1 = [sword2,spear1,mace1,bow1,wand1,healingPotion2,healingPotion2,healingPotion3,healthPotion,invisibilityPotion,StrengthPotion]
var itemList2 = []

func _ready():
	pass

func placeSkills():
	if EffectGenerator.atCastle != "castle":
		var i = randi()%itemList1.size()
		get_node("/root/MainScene/Floor/ItemMarket/Market/SkillTable/KinematicBody2D2").add_child(itemList1[i].instance())
		get_node("SkillTable")._readyItem()
		itemList1.remove(i)
		
		i = randi()%itemList1.size()
		get_node("/root/MainScene/Floor/ItemMarket/Market/SkillTable2/KinematicBody2D2").add_child(itemList1[i].instance())
		get_node("SkillTable2")._readyItem()
		itemList1.remove(i)
		
		i = randi()%itemList1.size()
		get_node("/root/MainScene/Floor/ItemMarket/Market/SkillTable3/KinematicBody2D2").add_child(itemList1[i].instance())
		get_node("SkillTable3")._readyItem()
		itemList1.remove(i)
	
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
