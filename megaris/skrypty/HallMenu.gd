extends Sprite

onready var trainingCamp = get_node("/root/MainScene/Floor/TrainingCamp/Market")
onready var playerStats = get_node('/root/MainScene/CanvasLayer/Control3')
onready var skillLabel = get_node("SkillsModifications")

func _on_Button_pressed():
	visible = false

func calculateSkillModifications():
	skillLabel.text = ""
	if trainingCamp.levelOfWeponSkill != 0:
		skillLabel.text = skillLabel.text + "- " + "Max Attack +" + String(trainingCamp.levelOfWeponSkill * 2)
	if trainingCamp.levelOfHpSkill != 0:
		skillLabel.text = skillLabel.text + "\n- " + "Max Hp +" + String(trainingCamp.levelOfHpSkill * 10)
	if playerStats.attackSpeedBonus != 1:
		skillLabel.text = skillLabel.text + "\n- " + "Attack Speed +" + String((1 - playerStats.attackSpeedBonus)*100) + "%"
	if playerStats.potionDuration != 0:
		skillLabel.text = skillLabel.text + "\n- " + "Potion Duration +" + String(playerStats.potionDuration)
	if playerStats.spawnMoreFountains != 0:
		skillLabel.text = skillLabel.text + "\n- " + "+ 1 Fountain On Each Stage"
	if playerStats.bonusCoins != 0:
		skillLabel.text = skillLabel.text + "\n- " + "Bonus +" + String(playerStats.bonusCoins) + " Coins From Monsters"
	if playerStats.bulletRangeImprovement != 0:
		skillLabel.text = skillLabel.text + "\n- " + "Bullet Range +" + String((playerStats.bulletRangeImprovement - 1)*100) + "%"
	if playerStats.crystalBonus != 0:
		skillLabel.text = skillLabel.text + "\n- " + "+" + String((playerStats.crystalBonus)*10) + "% Crystals"
	if playerStats.bossSlayerBonus != 1:
		skillLabel.text = skillLabel.text + "\n- " + "Boss Damage +" + String((playerStats.bossSlayerBonus - 1)*100) + "%"
	if playerStats.slimeAttackBonus != 1:
		skillLabel.text = skillLabel.text + "\n- " + "Damage To Slimes +" + String((playerStats.slimeAttackBonus - 1)*100) + "%"
	if playerStats.levelOfWepon == 1:
		skillLabel.text = skillLabel.text + "\n- " + "Steel Sword On Start"
	if playerStats.levelOfItem == 1:
		skillLabel.text = skillLabel.text + "\n- " + "Healing Potion II On Start"
	if playerStats.levelOfItem == 2:
		skillLabel.text = skillLabel.text + "\n- " + "Healing Potion III On Start"
