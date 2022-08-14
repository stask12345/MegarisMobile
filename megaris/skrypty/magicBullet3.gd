extends bullet

var monster = null

func _process(_delta): #unikalne dla każdego pocisku
	if !destroyed:
		if monster != null:
			look_at(monster.global_position)
		move_and_slide(Vector2(700,0).rotated(rotation))
	if destroyed:
		$AnimationPlayer.play("destroyAnimation")


func _on_Area2D_area_entered(area): #kontakt z mobkiem Area_attack
	if area.name == "monsterBody":
		var monsterP = area.get_parent()
		if !monsterP.hpDelay:
			attackMonster(monsterP)
			destroyed = true


func _on_Area2D_terrain_body_entered(_body): #kontakt z ziemią Area_terrain
	destroyed = true



func _on_Area2D_trigger_area_entered(area):
	if "monster" in area.name:
		if monster == null: monster = area.get_parent()


func _on_Area2D_trigger_area_exited(area):
	if "monster" in area.name:
		if area.get_parent() == null and monster == null:
			monster = null
			return
		if area.get_parent() == monster: monster = null
