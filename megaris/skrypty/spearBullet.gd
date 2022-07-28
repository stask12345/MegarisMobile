extends bullet

func _process(delta):
	if !destroyed:
		if !"Double" in get_parent().name:
			move_and_slide(Vector2(550,0).rotated(rotation))
		else:
			if get_parent().scale.x == 1: move_and_slide(Vector2(550,0).rotated(get_parent().rotation))
			else: move_and_slide(Vector2(550,0).rotated(get_parent().rotation-135))
		if $Pocisk.self_modulate.a > 0: $Pocisk.self_modulate.a = $Pocisk.self_modulate.a - 0.04


func _on_Area2D_area_entered(area): #kontakt z mobkiem Area_attack
	if area.name == "monsterBody":
		var monster = area.get_parent()
		if !monster.hpDelay:
			attackMonster(monster)

