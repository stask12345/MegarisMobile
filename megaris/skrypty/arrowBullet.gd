extends bullet

func _process(delta): #unikalne dla każdego pocisku
	if !destroyed:
		if !"Double" in get_parent().name:
			if direction == -1 and (global_rotation_degrees > 90 or global_rotation_degrees < 0): rotation = rotation - 0.04
			if direction == 1 and (global_rotation_degrees < 90 or global_rotation_degrees < 0): rotation = rotation + 0.04
		if $Pocisk.rotation > 120:
				$Pocisk.rotate(0.02)
		move_and_slide(Vector2(700,0).rotated(rotation))
	if destroyed:
		$AnimationPlayer.play("destroyAnimation")


func _on_Area2D_area_entered(area): #kontakt z mobkiem Area_attack
	if area.name == "monsterBody":
		var monster = area.get_parent()
		if !monster.hpDelay:
			attackMonster(monster)
			destroyed = true


func _on_Area2D_terrain_body_entered(body): #kontakt z ziemią Area_terrain
	destroyed = true
