extends Sprite

var loading = false

func loadingAd():
	visible = true
	get_tree().paused = true
	loading = true
	$AnimationPlayer.play("idle")
	checkLoadingOfAdd()

func loadingFailed():
	$AnimationPlayer.stop()
	$label3.text = "Loading Failed!"
	yield(get_tree().create_timer(0.4), "timeout")
	loadingEnds()

func loadingEnds():
	loading = false
	get_tree().paused = false
	$AnimationPlayer.stop()
	visible = false

func checkLoadingOfAdd():
	yield(get_tree().create_timer(12), "timeout")
	if loading:
		loadingFailed()
