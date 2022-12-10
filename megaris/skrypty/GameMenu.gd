extends Sprite

var music = true
var sound = true
var credits = true

func _ready():
	musicSettings()
	setMenu()

func musicSettings():
	if !music:
		get_node("/root/MainScene/MusicPlayer/BackgroundAudioDeflaut").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/BackgroundAudioReward").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/BackgroundAudioBoss").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/BackgroundAudioVictory").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/BackgroundAudioDefeat").stream_paused = true
	if music:
		get_node("/root/MainScene/MusicPlayer/BackgroundAudioDeflaut").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/BackgroundAudioReward").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/BackgroundAudioBoss").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/BackgroundAudioVictory").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/BackgroundAudioDefeat").stream_paused = false
	
	if !sound:
		get_node("/root/MainScene/MusicPlayer/SoundEffectTeleportation").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectFireball").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectExplosion").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectExplosionQuiet").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectDrink").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundSlime").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundMonsterDeath").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectCoin").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectFountain").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectTable").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectChest").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectSkill").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectRumble").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectTrap").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectTap").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundBat").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectMonsterShoot").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectMonsterThump").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectMonsterGrowl").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectGhost").stream_paused = true
		get_node("/root/MainScene/MusicPlayer/SoundEffectSummon").stream_paused = true
		get_node("/root/MainScene/Player").playMusic = false
		get_node("/root/MainScene/Player/WeponHolder").playMusic = false
		get_node("/root/MainScene/Player/SoundEffectOuch").stream_paused = true
		get_node("/root/MainScene/CanvasLayer/Control4/AnvilMenu/SoundEffectAnvil").stream_paused = true
		get_node("/root/MainScene/CanvasLayer/Control4/ShopMenu/SoundEffectShop").stream_paused = true
		get_node("/root/MainScene/CanvasLayer/Control5/SoundEffectEqSwitch").stream_paused = true
		get_node("/root/MainScene/CanvasLayer/Control5/SoundEffectEqPut").stream_paused = true
	
	if sound:
		get_node("/root/MainScene/MusicPlayer/SoundEffectTeleportation").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectFireball").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectExplosion").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectExplosionQuiet").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectDrink").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundSlime").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundMonsterDeath").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectCoin").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectFountain").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectTable").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectChest").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectSkill").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectRumble").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectTrap").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectTap").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundBat").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectMonsterShoot").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectMonsterThump").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectMonsterGrowl").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectGhost").stream_paused = false
		get_node("/root/MainScene/MusicPlayer/SoundEffectSummon").stream_paused = false
		get_node("/root/MainScene/Player").playMusic = true
		get_node("/root/MainScene/Player/WeponHolder").playMusic = true
		get_node("/root/MainScene/Player/SoundEffectOuch").stream_paused = false
		get_node("/root/MainScene/CanvasLayer/Control4/AnvilMenu/SoundEffectAnvil").stream_paused = false
		get_node("/root/MainScene/CanvasLayer/Control4/ShopMenu/SoundEffectShop").stream_paused = false
		get_node("/root/MainScene/CanvasLayer/Control5/SoundEffectEqSwitch").stream_paused = false
		get_node("/root/MainScene/CanvasLayer/Control5/SoundEffectEqPut").stream_paused = false

func setMenu():
	if music:
		$"Menu-music".modulate = Color(1,0.73,0)
	else:
		$"Menu-music".modulate = Color(0.24,0.24,0.24)
	
	if sound:
		$"Menu-music2".modulate = Color(1,0.73,0)
	else:
		$"Menu-music2".modulate = Color(0.24,0.24,0.24)
	
	musicSettings()

func _on_Button_pressed():
	get_tree().paused = false
	musicSettings()
	visible = false


func _on_ButtonLeave_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_ButtonMusic_pressed():
	if music:
		music = false
	else:
		music = true
	setMenu()
	get_node("/root/MainScene").saveData()


func _on_ButtonSound_pressed():
	if sound:
		sound = false
	else:
		sound = true
	setMenu()
	get_node("/root/MainScene").saveData()


func _on_ButtonCredits_pressed():
	pass # Replace with function body.

func save():
	var node_data = {
		"music": music,
		"sound": sound,
		"credits": credits,
		"nodePath": get_path()
		}
	return node_data

