extends Sprite

func _on_Area2D_area_entered(area):
	get_node("/root/MainScene/EffectGenerator/AnimationPlayer").play("teleportFromTutorial")
