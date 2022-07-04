extends Area2D

onready var monster = get_parent()

func _on_MovementControlerMonster_area_entered(area):
	if area.get_parent().name == "Ladder":
		monster.ladderOrWall = true
		if monster.global_position.x - area.global_position.x > 0: monster.directionOfBlocade = false
		else: monster.directionOfBlocade = true
	if area.get_parent().name == "Player":
		monster.getBack = true


func _on_MovementControlerMonster_area_exited(area):
	if area.get_parent().name == "Ladder":
		monster.ladderOrWall = false
		
	if area.get_parent().name == "Player":
		monster.getBack = false

