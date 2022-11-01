extends Node2D

onready var detectionArea
onready var player = get_node("/root/MainScene/Player")

func _ready():
	detectionArea = get_parent().get_parent().get_node("Stage6")

func _on_DetectorHigh_area_entered(area):
	if "monster" in area.name and area.get_parent() is monsterClass:
		var m = area.get_parent()
		if !m.flying:
			if m.get_parent() == detectionArea:
				m.get_parent().call_deferred("remove_child",m)
				get_parent().call_deferred("add_child",m)
		if m.flying:
			if m.global_position.y < player.global_position.y:
				if m.get_parent() == detectionArea:
					m.get_parent().call_deferred("remove_child",m)
					get_parent().call_deferred("add_child",m)
			if m.global_position.y > player.global_position.y:
				if m.get_parent() != detectionArea:
					m.get_parent().call_deferred("remove_child",m)
					detectionArea.call_deferred("add_child",m)
