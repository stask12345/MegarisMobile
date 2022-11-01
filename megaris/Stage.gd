extends Node2D

onready var visibility_notifier := $VisibilityNotifier2D

func _ready():
	visibility_notifier.connect("screen_entered",self,"show")
	visibility_notifier.connect("screen_exited",self,"hide")
	visible = false

func shakeScreen():
	get_node("/root/MainScene/Player/AnimationPlayerCamera").play("cameraShaking")
	get_node("/root/MainScene/MusicPlayer").playRumble()

func returnToPlayer():
	get_node("/root/MainScene/Player/Player/Camera2D").position = Vector2(0,0)
	get_node("/root/MainScene/CanvasLayer").makeUIVisible()
	get_node("/root/MainScene/Player").trapped = false


func _on_Area2Dfinal_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("final")

func lightOff():
	get_node("/root/MainScene/EffectGenerator/AnimationPlayer").play("light_off")
