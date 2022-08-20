extends Sprite

onready var weponHolder = get_node("/root/MainScene/CanvasLayer/Control4/WeponHolder")
onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")
onready var player = get_node("/root/MainScene/Player/Player")

var costOfWeponUpgrade = [20,30]
var costOfArmorUpgrade = [50,150,250]

func _ready():
	pass

func showArmory():
	$WeponImage.texture = weponHolder.get_child(0).texture
	if $WeponImage.texture.get_height() > 80:
		$WeponImage.scale = Vector2(1.1,1.1)
	else:
		$WeponImage.scale = Vector2(1.3,1.3)
	$ArmorImage.texture = player.texture
	
	if weponHolder.get_child(0).upgradeLevel < 2:
		$weponCostLabel.text = String(costOfWeponUpgrade[weponHolder.get_child(0).upgradeLevel])
		$weponDesLabel.text = "+" + String((weponHolder.get_child(0).upgradeLevel + 1)*5) + " max attack"
	else: $weponCostLabel.text = ""
	if playerStats.levelOfArmor < 3:
		$armorDesLabel.text = "+" + String((playerStats.levelOfArmor + 1)*5) + " armor"
		$armorCostLabel.text = String(costOfArmorUpgrade[playerStats.levelOfArmor])
	else: $armorCostLabel.text = ""
	
	if weponHolder.get_child(0).upgradeLevel == 2: 
		$BuyWepon.text = "Max Level"
		$weponCostLabel/GoldBag.visible = false
	else: 
		$BuyWepon.text = "Upgrade"
		$weponCostLabel/GoldBag.visible = true
	if playerStats.levelOfArmor == 3: 
		$BuyArmor.text = "Max Level"
		$armorCostLabel/GoldBag.visible = false
	else: 
		$BuyArmor.text = "Upgrade"
		$armorCostLabel/GoldBag.visible = true


func _on_Button_pressed(): #back button
	visible = false


func _on_BuyWeponButton_pressed():
	if weponHolder.get_child(0).upgradeLevel < 2 and playerStats.gold >= costOfWeponUpgrade[weponHolder.get_child(0).upgradeLevel]:
		playerStats.gold -= costOfWeponUpgrade[weponHolder.get_child(0).upgradeLevel]
		weponHolder.get_child(0).upgradeLevel += 1
		weponHolder.get_child(0).maxDamage += 5
		$AnimationPlayer.play("upgradeWepon")
		showArmory()


func _on_BuyArmorButton2_pressed():
	if playerStats.levelOfArmor < 3 and playerStats.gold >= costOfArmorUpgrade[playerStats.levelOfArmor]:
		playerStats.gold -= costOfArmorUpgrade[playerStats.levelOfArmor]
		playerStats.levelOfArmor += 1
		playerStats.updatePlayerLook()
		$AnimationPlayer.play("armorAnimation")
		showArmory()
