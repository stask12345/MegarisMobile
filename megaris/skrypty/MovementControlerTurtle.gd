extends Area2D

onready var monster = get_parent()

func _on_MovementControlerMonster_area_entered(area):
	if area.get_parent().name == "Ladder":
		monster.ladder = true
		if monster.global_position.x - area.global_position.x > 0: monster.directionOfLadder = false
		else: monster.directionOfLadder = true


func _on_MovementControlerMonster_area_exited(area):
	if area.get_parent().name == "Ladder":
		monster.ladder = false

