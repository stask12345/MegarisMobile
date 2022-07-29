extends bullet
func _ready():
	$AnimationPlayer.play("destroyAnimation")
	#timerToDestroy()



func _on_Area2D_area_entered(area): #kontakt z mobkiem Area_attack
	if area.name == "monsterBody":
		var monster = area.get_parent()
		if !monster.hpDelay:
			attackMonster(monster)

