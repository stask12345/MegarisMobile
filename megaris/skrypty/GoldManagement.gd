extends Control

var gold = 0
var totalCollected = 0
var crystals = 0
var levelOfArmor = 0
var strengthIncrease = 1
var killedMonster = 0
var playerAnimationWalking1 = preload("res://grafika/animation/player_animation1.png")
var playerAnimationWalking2 = preload("res://grafika/animation/player_animation2.png")
var playerAnimationWalking3 = preload("res://grafika/animation/player_animation3.png")
var playerAnimationCliming1 = preload("res://grafika/animation/player_climing_animation1.png")
var playerAnimationCliming2 = preload("res://grafika/animation/player_climing_animation2.png")
var playerAnimationCliming3 = preload("res://grafika/animation/player_climing_animation3.png")
onready var player = get_node("/root/MainScene/Player")

func _process(delta):
	if Input.is_key_pressed(16777351):
		save()
	if Input.is_key_pressed(16777229):
		$Hp.hp = 0
	$Crystals.text = String(crystals)
	$Gold.text = String(gold)

func updatePlayerLook():
	if levelOfArmor == 1:
		player.get_node("Player").texture = playerAnimationWalking1
		player.get_node("PlayerCliming").texture = playerAnimationCliming1
	if levelOfArmor == 2:
		player.get_node("Player").texture = playerAnimationWalking2
		player.get_node("PlayerCliming").texture = playerAnimationCliming2
	if levelOfArmor == 3:
		player.get_node("Player").texture = playerAnimationWalking3
		player.get_node("PlayerCliming").texture = playerAnimationCliming3

func make_invisible(InvisibleTime):
	player.get_node("Player").self_modulate.a = 0.4
	player.get_node("PlayerCliming").self_modulate.a = 0.4
	player.get_node("Area2D").invisible = true
	yield(get_tree().create_timer(InvisibleTime),"timeout")
	player.get_node("Player").self_modulate.a = 1
	player.get_node("PlayerCliming").self_modulate.a = 1
	player.get_node("Area2D").invisible = false

func make_stronger(strongerTime):
	player.get_node("HighLight").enabled = true#to do by naprawde zwiekszało damage
	strengthIncrease = 2
	yield(get_tree().create_timer(strongerTime),"timeout")
	player.get_node("HighLight").enabled = false#to do by naprawde zwiekszało damage
	strengthIncrease = 1

func save():
	var node_data = {
		"crystals": crystals,
		"nodePath": get_path()
		}
	return node_data
