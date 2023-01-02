extends Sprite

var healCrystal = false #false Heal #true crystals

func _ready():
	MobileAds.connect("rewarded_ad_loaded", self, "_on_MobileAds_rewarded_ad_loaded")
	MobileAds.connect("rewarded_ad_closed", self, "_on_MobileAds_rewarded_ad_closed")
	MobileAds.connect("rewarded_ad_clicked", self, "_on_MobileAds_rewarded_ad_clicked")
	MobileAds.connect("rewarded_ad_opened", self, "_on_MobileAds_rewarded_ad_opened")
	MobileAds.connect("user_earned_rewarded", self, "_on_MobileAds_user_earned_rewarded")
	MobileAds.connect("rewarded_ad_failed_to_load", self, "_on_MobileAds_rewarded_ad_failed_to_load")
	MobileAds.connect("rewarded_ad_failed_to_show", self, "_on_MobileAds_rewarded_ad_failed_to_show")

func _on_MobileAds_user_earned_rewarded(currency : String, amount : int) -> void:
	get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/AdLoadingMenu").loadingEnds()
	if !healCrystal:
		$"../Hp".hp += 50
		get_node("/root/MainScene/Player").changeColor(Color.green,true)
		get_node("/root/MainScene/MusicPlayer").playDrink()
	if healCrystal:
		var c = $"../../Control-DeathScreen".crystals
		c += $"../../Control-DeathScreen".adCrystals
		$"../../Control-DeathScreen/Crystals/CrystalCount".text = String(c)
		$"..".crystals += $"../../Control-DeathScreen".adCrystals
		get_node("/root/MainScene").saveData()

func _on_MobileAds_rewarded_ad_loaded() -> void:
	MobileAds.show_rewarded()

func _on_MobileAds_rewarded_ad_closed() -> void:
	get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/AdLoadingMenu").loadingEnds()

func _on_MobileAds_rewarded_ad_opened():
	pass

func _on_MobileAds_rewarded_ad_clicked():
	pass

func _on_MobileAds_rewarded_ad_failed_to_load(error_code):
	get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/AdLoadingMenu").loadingFailed()

func _on_MobileAds_rewarded_ad_failed_to_show(error_code):
	get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/AdLoadingMenu").loadingFailed()

func _on_TouchScreenButton_pressed():
	if !$"..".addHpWatched:
		healCrystal = false
		get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/AdLoadingMenu").loadingAd()
		MobileAds.load_rewarded()
		$"..".addHpWatched = true
		visible = false



func _on_TouchScreenButtonCrystals_pressed():
	healCrystal = true
	get_node("/root/MainScene/CanvasLayer/Control-DeathScreen/AdLoadingMenu").loadingAd()
	MobileAds.load_rewarded()
	$"../../Control-DeathScreen/Crystals/Tv".visible = false
