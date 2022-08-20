extends Node

onready var buyButton = get_node("/root/MainScene/CanvasLayer/Control4/Buy")
onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
var costOfSkillMarket = 1
var bought = false

func _ready():
	$BuildSite/Label.text = String(costOfSkillMarket)
	if !bought:
		$BuildSite.visible = true;
		$Market.visible = false;
	if bought:
		$Market.visible = true;
		$BuildSite.visible = false;
		if playerStats.slayedFirstBoss: $Market/Statue1.visible = true
		get_node("Market/Area2D/CollisionShape2D").disabled = false
		get_node("BuildSite/Area2D/CollisionShape2D").disabled = true

func buy():
	if playerStats.crystals >= costOfSkillMarket:
		playerStats.crystals -= costOfSkillMarket
		bought = true
		buyButton.visible = false
		get_node("/root/MainScene/Player/AnimationPlayerCamera").play("CameraShakingShort")
		$BuildingEffect/AnimationPlayer.play("idle")
		_ready()


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		buyButton.objectToBuy = self
		buyButton.visible = true
		buyButton.get_child(0).play("pick_up_sight_animation")
		buyButton.get_child(2).text = "Stats & Quests Board"


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		buyButton.visible = false
		buyButton.get_child(0).stop()
		buyButton.get_child(2).text = ""

func save():
	var node_data = {
		"bought": bought,
		"nodePath": get_path()
		}
	return node_data
