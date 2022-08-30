extends Node2D

onready var visibility_notifier := $VisibilityNotifier2D

func _ready():
	visibility_notifier.connect("screen_entered",self,"show")
	visibility_notifier.connect("screen_exited",self,"hide")
	visible = false
