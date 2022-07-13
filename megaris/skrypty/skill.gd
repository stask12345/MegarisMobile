extends Node2D
class_name skill

onready var player = get_node("/root/MainScene/Player")
onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var playerStatsHp = get_node("/root/MainScene/CanvasLayer/Control3/Hp")
var rewardSkill = false
var costOfSkill = 0 
var bought = false
var description = ""

func save():
	var node_data = {
		"bought": bought,
		"nodePath": get_path()
		}
	return node_data
