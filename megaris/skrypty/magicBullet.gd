extends bullet


func _process(_delta):
	if !destroyed:
		move_and_slide(Vector2(550,0).rotated(rotation))
	if destroyed:
		$AnimationPlayer.play("destroyAnimation")


func _on_Area2D_area_entered(area): #kontakt z mobkiem Area_attack
	if area.name == "monsterBody":
		var monster = area.get_parent()
		if !monster.hpDelay:
			attackMonster(monster)

func _on_Area2D_terrain_body_entered(_body): #kontakt z ziemią Area_terrain
	destroyed = true
