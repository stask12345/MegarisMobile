extends Sprite

onready var avaiableSkills = get_node("/root/MainScene/Skills")

func _ready():
	randomize()

func placeSkills():
	var skillsToBuy = []
	for s in avaiableSkills.get_children():
		if !s.bought:
			if s.lesserSkill == null || avaiableSkills.get_node(s.lesserSkill.name).bought == true:
				if s.lesserSkill != null: print(s.lesserSkill.name)
				skillsToBuy.push_front(s)
				print(s.name)
	
	if skillsToBuy.size() > 0:
		var s = skillsToBuy[randi()%skillsToBuy.size()]
		s.get_parent().remove_child(s)
		s.position = Vector2(0,0)
		get_node("SkillTable/KinematicBody2D2").add_child(s)
		get_node("SkillTable")._readyItem()
		skillsToBuy.erase(s)
	
	if skillsToBuy.size() > 0:
		var s = skillsToBuy[randi()%skillsToBuy.size()]
		s.get_parent().remove_child(s)
		s.position = Vector2(0,0)
		get_node("SkillTable2/KinematicBody2D2").add_child(s)
		get_node("SkillTable2")._readyItem()
		skillsToBuy.erase(s)

	if skillsToBuy.size() > 0:
		var s = skillsToBuy[randi()%skillsToBuy.size()]
		s.get_parent().remove_child(s)
		s.position = Vector2(0,0)
		get_node("SkillTable3/KinematicBody2D2").add_child(s)
		get_node("SkillTable3")._readyItem()
		skillsToBuy.erase(s)
	
	makeTablesEmpty()

func makeTablesEmpty():
	if (get_node("SkillTable/KinematicBody2D2").get_child_count() > 0 and get_node("SkillTable/KinematicBody2D2").get_child(0).bought) or get_node("SkillTable/KinematicBody2D2").get_child_count() == 0:
		get_node("SkillTable/Label").visible = false
		get_node("SkillTable/Area2D/CollisionShape2D").disabled = true
	if (get_node("SkillTable2/KinematicBody2D2").get_child_count() > 0 and get_node("SkillTable2/KinematicBody2D2").get_child(0).bought) or get_node("SkillTable2/KinematicBody2D2").get_child_count() == 0:
		get_node("SkillTable2/Label").visible = false
		get_node("SkillTable2/Area2D/CollisionShape2D").disabled = true
	if (get_node("SkillTable3/KinematicBody2D2").get_child_count() > 0 and get_node("SkillTable3/KinematicBody2D2").get_child(0).bought) or get_node("SkillTable3/KinematicBody2D2").get_child_count() == 0:
		get_node("SkillTable3/Label").visible = false
		get_node("SkillTable3/Area2D/CollisionShape2D").disabled = true
