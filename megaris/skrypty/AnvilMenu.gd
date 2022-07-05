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
	$ArmorImage.texture = player.texture
	if weponHolder.get_child(0).upgradeLevel < 2:
		$weponCostLabel.text = String(costOfWeponUpgrade[weponHolder.get_child(0).upgradeLevel]) + " Gold"
	else: $weponCostLabel.text = ""
	if playerStats.levelOfArmor < 3:
		$armorCostLabel.text = String(costOfArmorUpgrade[playerStats.levelOfArmor]) + " Gold"
	else: $armorCostLabel.text = ""
	$weponUpgNumLabel.text = String(weponHolder.get_child(0).upgradeLevel) + "/2"
	$armorUpgNumLabel.text = String(playerStats.levelOfArmor) + "/3"
	if weponHolder.get_child(0).upgradeLevel == 2: $BuyWepon.text = "Max"
	else: $BuyWepon.text = "Buy"
	if playerStats.levelOfArmor == 3: $BuyArmor.text = "Max"
	else: $BuyArmor.text = "Buy"


func _on_Button_pressed(): #back button
	visible = false


func _on_BuyWeponButton_pressed():
	if weponHolder.get_child(0).upgradeLevel < 2 and playerStats.gold >= costOfWeponUpgrade[weponHolder.get_child(0).upgradeLevel]:
		playerStats.gold -= costOfWeponUpgrade[weponHolder.get_child(0).upgradeLevel]
		weponHolder.get_child(0).upgradeLevel += 1
		weponHolder.get_child(0).maxDamage += 5
		showArmory()


func _on_BuyArmorButton2_pressed():
	if playerStats.levelOfArmor < 3 and playerStats.gold >= costOfArmorUpgrade[playerStats.levelOfArmor]:
		playerStats.gold -= costOfArmorUpgrade[playerStats.levelOfArmor]
		playerStats.levelOfArmor += 1
		playerStats.updatePlayerLook()
		showArmory()
