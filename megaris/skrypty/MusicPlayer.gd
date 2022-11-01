extends Node

func playTeleportation():
	$SoundEffectTeleportation.play()

func playDrink():
	$SoundEffectDrink.play()

func playFireball():
	$SoundEffectFireball.play()

func playExpolosion():
	$SoundEffectExplosion.play()

func playExpolosionQuiet():
	$SoundEffectExplosionQuiet.play()

func playSlime():
	$SoundSlime.play()

func playMonsterDeath():
	$SoundMonsterDeath.play()

func playCoin():
	$SoundEffectCoin.play()

func playFountain():
	$SoundEffectFountain.play()

func playTable():
	$SoundEffectTable.play()

func playChest():
	$SoundEffectChest.play()

func playSkill():
	$SoundEffectSkill.play()

func playRumble():
	$SoundEffectRumble.play()

func playBossTheme():
	$BackgroundAudioDeflaut.stop()
	$BackgroundAudioBoss.play()

func playDefeatTheme():
	$BackgroundAudioDeflaut.stop()
	$BackgroundAudioBoss.stop()
	$BackgroundAudioVictory.stop()
	$BackgroundAudioDefeat.play()

func playDeflautTheme():
	$BackgroundAudioReward.stop()
	$BackgroundAudioDeflaut.play()
	$BackgroundAudioBoss.stop()
	$BackgroundAudioVictory.stop()
	$BackgroundAudioVictory.stop()

func playVictoryTheme():
	$BackgroundAudioDeflaut.stop()
	$BackgroundAudioBoss.stop()
	$BackgroundAudioVictory.play()

func playRewardTheme():
	$BackgroundAudioBoss.stop()
	$BackgroundAudioDeflaut.stop()
	$BackgroundAudioReward.play()

func playTrap():
	$SoundEffectTrap.play()

func playtap():
	$SoundEffectTap.play()

func playBat():
	$SoundBat.play()

func playMonsterShoot():
	$SoundEffectMonsterShoot.play()

func playThump():
	$SoundEffectMonsterThump.play()

func playGhost():
	$SoundEffectGhost.play()

func playMonsterGrowl():
	$SoundEffectMonsterGrowl.play()

func playSummon():
	$SoundEffectSummon.play()
