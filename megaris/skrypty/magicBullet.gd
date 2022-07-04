extends bullet

func _process(delta):
	if !destroyed:
		move_and_slide(Vector2(550,0).rotated(rotation))
		if $Pocisk.self_modulate.a > 0: $Pocisk.self_modulate.a = $Pocisk.self_modulate.a - 0.03
	if destroyed:
		$Pocisk.self_modulate.a = 1
		$AnimationPlayer.play("destroyAnimation")


func _on_Area2D_area_entered(area): #kontakt z mobkiem Area_attack
	if area.name == "monsterBody":
		var monster = area.get_parent()
		if !monster.hpDelay:
			attackMonster(monster)
			destroyed = true


func _on_Area2D_terrain_body_entered(body): #kontakt z ziemią Area_terrain
	destroyed = true

