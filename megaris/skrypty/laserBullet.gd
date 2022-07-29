extends bullet
var playerPosition = Vector2()
func _ready():
	playerPosition = player.global_position

func _process(delta):
#	global_position.x += (player.global_position.x - playerPosition.x)#Unikalne dla maczugi Atak przy graczu
#	global_position.y += (player.global_position.y - playerPosition.y)
	playerPosition = player.global_position


func _on_Area2D_area_entered(area): #kontakt z mobkiem Area_attack
	if area.name == "monsterBody":
		var monster = area.get_parent()
		if !monster.hpDelay:
			attackMonster(monster)

