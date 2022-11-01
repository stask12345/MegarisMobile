extends bullet
onready var magicBullet = preload("res://instances/Bullets/magicBullet2.tscn")
var monster = null

func _ready():
	shoot()

func shoot():
	if !destroyed and monster != null:
		var b = magicBullet.instance()
		b.shorterRange = true
		get_node("/root/MainScene/Player/WeponHolder").add_child(b)
		b.global_position = global_position
		b.look_at(monster.global_position)
	
	$Timer.start(0.5)
	yield($Timer,"timeout")
	shoot()

func _on_Area2D_area_entered(area): #kontakt z mobkiem Area_attack
	if "monster" in area.name:
		if monster == null:
			monster = area.get_parent()

func _on_Area2D_area_exited(area):
	if "monster" in area.name:
		if area.get_parent() == null and monster == null:
			monster = null
			return
		if area.get_parent() == monster: 
			monster = null
