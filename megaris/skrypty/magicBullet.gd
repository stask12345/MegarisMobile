extends bullet

func _process(_delta): #unikalne dla każdego pocisku
	if !destroyed:
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
