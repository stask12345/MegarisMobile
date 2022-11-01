extends Node2D


func _ready():
	print("gwiazda zanek")


func _on_Area2DBoss_body_entered(body): #wejście do bossa
	if body.name == "Player":
		get_node("/root/MainScene/EffectGenerator").enterBossAreaCastle()
