extends Area2D

onready var slimeBody = get_parent()


func _on_RangeArea_body_entered(body):
	if body.name == "Player":
		slimeBody.playerInRange = true


func _on_RangeArea_body_exited(body):
	if body.name == "Player":
		slimeBody.playerInRange = false
