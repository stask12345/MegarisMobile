extends Node2D


func _ready():
	get_node("/root/MainScene/CanvasLayer/Control3").addHpWatched = false


func _on_Area2DBoss_body_entered(body): #wejście do bossa
	if body.name == "Player":
		get_node("/root/MainScene/EffectGenerator").enterBossAreaCastle()
