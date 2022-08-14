extends Sprite

var levelOfWeponSkill = 0
var levelOfHpSkill = 0

func _ready():
	placeSkills()

func placeSkills():
	var itemToAdd
	if levelOfWeponSkill == 0:
		itemToAdd = preload("res://instances/Skills/SkillW1.tscn").instance()
	if levelOfWeponSkill == 1:
		itemToAdd = preload("res://instances/Skills/SkillW2.tscn").instance()
	if levelOfWeponSkill == 2:
		itemToAdd = preload("res://instances/Skills/SkillW3.tscn").instance()
	if levelOfWeponSkill == 3:
		itemToAdd = preload("res://instances/Skills/SkillW4.tscn").instance()
	if levelOfWeponSkill == 4:
		itemToAdd = preload("res://instances/Skills/SkillW5.tscn").instance()
	if levelOfWeponSkill == 5:
		itemToAdd = preload("res://instances/Skills/SkillW6.tscn").instance()
		$SkillTable/Area2D/CollisionShape2D.disabled = true
	
	$SkillTable/KinematicBody2D2.add_child(itemToAdd)
	$SkillTable.skillInScript = itemToAdd
	$SkillTable.showCostLabel()
	
	if levelOfHpSkill == 0:
		itemToAdd = preload("res://instances/Skills/SkillH1.tscn").instance()
	if levelOfHpSkill == 1:
		itemToAdd = preload("res://instances/Skills/SkillH2.tscn").instance()
	if levelOfHpSkill == 2:
		itemToAdd = preload("res://instances/Skills/SkillH3.tscn").instance()
	if levelOfHpSkill == 3:
		itemToAdd = preload("res://instances/Skills/SkillH4.tscn").instance()
	if levelOfHpSkill == 4:
		itemToAdd = preload("res://instances/Skills/SkillH5.tscn").instance()
	if levelOfHpSkill == 5:
		itemToAdd = preload("res://instances/Skills/SkillH6.tscn").instance()
		$SkillTable2/Area2D/CollisionShape2D.disabled = true
	
	$SkillTable2/KinematicBody2D2.add_child(itemToAdd)
	$SkillTable2.skillInScript = itemToAdd
	$SkillTable2.showCostLabel()

func save():
	var node_data = {
		"levelOfWeponSkill": levelOfWeponSkill,
		"levelOfHpSkill": levelOfHpSkill,
		"nodePath": get_path()
		}
	return node_data
