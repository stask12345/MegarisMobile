extends Node2D

onready var buyButton = get_node("/root/MainScene/CanvasLayer/Control4/Buy")
onready var visibility_notifier := $VisibilityNotifier2D
var costOfSkillMarket = 10
var bought = false
var doOnce = false

func _ready():
	$BuildSite/Label.text = String(costOfSkillMarket)
	if !bought:
		$BuildSite.visible = true;
		$Market.visible = false;
	if bought:
		$Market.visible = true;
		$BuildSite.visible = false;
		$Market.placeSkills()
		get_node("BuildSite/Area2D/CollisionShape2D").disabled = true
	if !doOnce:
		doOnce = true
		visibility_notifier.connect("screen_entered",self,"show")
		visibility_notifier.connect("screen_exited",self,"hide")
		visible = false

func buy():
	var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
	if playerStats.crystals >= costOfSkillMarket:
		playerStats.crystals -= costOfSkillMarket
		bought = true
		buyButton.visible = false
		get_node("BuildSite/Area2D/CollisionShape2D").disabled = true
		get_node("/root/MainScene/Player/AnimationPlayerCamera").play("CameraShakingShort")
		$BuildingEffect/AnimationPlayer.play("idle")
		_ready()
		get_node("/root/MainScene").saveData()
		get_node("/root/MainScene/MusicPlayer").playRumble()


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		buyButton.objectToBuy = self
		buyButton.visible = true
		buyButton.get_child(0).play("pick_up_sight_animation")
		buyButton.get_child(2).text = "Skill Market"


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
