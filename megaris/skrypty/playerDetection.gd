extends Area2D

onready var slimeBody = get_parent()

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		slimeBody.goingToPlayer = true
		slimeBody.aggro = true


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		slimeBody.loseTriggerOnPlayer()
