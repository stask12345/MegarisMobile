extends Area2D


func _ready():
	pass


func _on_MonsterDetector_area_entered(area):
	if "monster" in area.name:
		print("zmiania monstera")
		var m = area.get_parent()
		get_parent().add_child(m)
		m.get_parent().remove_child(m)
