extends Sprite

onready var trainingCamp = get_node("/root/MainScene/Floor/TrainingCamp/Market")
onready var playerStats = get_node('/root/MainScene/CanvasLayer/Control3')
onready var skillLabel = get_node("SkillsModifications")

onready var fullLength = $ProgressBar.scale.x
var questProgress = 0
var rewards = [50,50,100,100,100,200]
var canProgress = false

func _on_Button_pressed():
	visible = false
	$QuestName/AnimationPlayer.stop()

func calculateSkillModifications():
	calculateQuest()
	
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

func calculateQuest():
	var goal = 0
	var current = 0
	
	if questProgress == 0:
		$QuestName.text = "Slay 100 Slimes!"
		current = playerStats.slimesSlayed
		goal = 100
	if questProgress == 1:
		$QuestName.text = "Possess 300 Gold Coins!"
		current = playerStats.maxGoldAcquired
		goal = 300
	if questProgress == 2:
		$QuestName.text = "Kill Slime King!"
		current = playerStats.slayedFirstBoss
		goal = 1
	if questProgress == 3:
		$QuestName.text = "Slay 75 Skeletons!"
		current = playerStats.skeletonsSlayed
		goal = 75
	if questProgress == 4:
		$QuestName.text = "Obtain 160 Max Hp!"
		current = playerStats.maxHpAcquired
		goal = 160
	if questProgress == 5:
		$QuestName.text = "Defeat The Final Boss!"
		current = playerStats.slayedSecondBoss
		goal = 1
	if questProgress == 6:
		$QuestName.text = "All Quests Completed!"
		current = 0
		goal = 1
		$Claim.visible = false
		$ProgressBar.visible = false
		$QuestBar.visible = false
		$Reward.visible = false
	
	var hpPrecent : float = current / goal
	print(hpPrecent)
	$ProgressBar.scale.x = fullLength * hpPrecent
	print($ProgressBar.scale.x)
	$QuestBar/Title3.text = String(current) + "/" + String(goal)
	
	$QuestName/AnimationPlayer.play("idle")
	if questProgress < rewards.size(): $Reward/Reward2.text = String(rewards[questProgress])
	
	if current >= goal:
		$Reward.visible = false
		$Claim.visible = true
		$Claim/AnimationPlayer.play("idle")
		canProgress = true



func _on_TouchScreenButton_released():
	if canProgress:
		$Claim/AnimationPlayer.stop()
		questProgress += 1
		if questProgress < rewards.size(): playerStats.crystals += rewards[questProgress]
		calculateQuest()
		canProgress = false

func save():
	var node_data = {
		"questProgress": questProgress,
		"nodePath": get_path()
		}
	return node_data
