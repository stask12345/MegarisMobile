extends Node

onready var playerStats = get_node("/root/MainScene/CanvasLayer/Control3")

var avilableList = [] #przechowuje wygenerowane numery wszystkich elentów by się nie powtarzały
var anvilList = [] #przechowuje numer platformy na ktorej ma sie wygenerowac dany element
var shopList = []
var fountainList = []
var trapList = []
var chestList = []
var itemTableList = []
var avilableNumbers #numery wszystkich platform
var numberOfPlatform = 1

var sword4 = preload("res://instances/Wepons/Sword4.tscn")
var sword5 = preload("res://instances/Wepons/Sword5.tscn")
var spear3 = preload("res://instances/Wepons/Spear3.tscn")
var spear4 = preload("res://instances/Wepons/Spear4.tscn")
var mace3 = preload("res://instances/Wepons/Mace3.tscn")
var mace4 = preload("res://instances/Wepons/Mace4.tscn")
var bow3 = preload("res://instances/Wepons/Bow3.tscn")
var bow4 = preload("res://instances/Wepons/Bow4.tscn")
var wand3 = preload("res://instances/Wepons/Wand3.tscn")
var wand4 = preload("res://instances/Wepons/Wand4.tscn")

var healingPotion3 = preload("res://instances/Items/PotionHealing3.tscn")
var healingPotion4 = preload("res://instances/Items/PotionHealing4.tscn")
var healthPotion = preload("res://instances/Items/PotionHealth2.tscn")
var invisibilityPotion = preload("res://instances/Items/PotionInvisibility2.tscn")
var StrengthPotion = preload("res://instances/Items/PotionStrength2.tscn")

var scroolFireBall = preload("res://instances/Items/SpellFireBall1.tscn")
var scroolExplosion = preload("res://instances/Items/SpellExplosion1.tscn")
var specialSword = preload("res://instances/Wepons/SpecialSword2.tscn")
var specialWand = preload("res://instances/Wepons/SpecialWand4.tscn")

var firstTierPotion = [healingPotion3,healingPotion3,healthPotion,invisibilityPotion,scroolFireBall]
var secondTierPotion = [healingPotion4,healingPotion4,healthPotion,invisibilityPotion,StrengthPotion,scroolExplosion]
var firstTierWeponList = [sword4,spear3,mace3,bow3,wand3,sword4,spear3,mace3,bow3,wand3,sword4,spear3,mace3,bow3,wand3,sword4,spear3,mace3,bow3,wand3,specialWand]
var secondTierWeponList = [sword5,spear4,mace4,bow4,wand4,sword5,spear4,mace4,bow4,wand4,sword5,spear4,mace4,bow4,wand4,sword5,spear4,mace4,bow4,wand4,specialSword]
var SpecialTierList = [specialWand,specialSword,scroolExplosion,wand4]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	generateWorld()

var numberOfTerrain = 14 #platform na 1 poziomie
var numberOfFloors = 12 #liczba poziomów 

func generateWorld():
	var passages = [0,1,2,3,4,5,6,7,8,9,10,11,12,13]
	var randomedPassages = [0,0]
	var nextRandomedPassages = [0,0]
	var currentFloorPassages
	var height = 660 #-320  ostatnie: -2540
	var width = -1750
	var g1 = preload("res://instances/Terrain/G4.tscn")
	var g2 = preload("res://instances/Terrain/G5.tscn")
	var g3 = preload("res://instances/Terrain/G6.tscn")
	var g4 = preload("res://instances/Terrain/G7.tscn")
	var g5 = preload("res://instances/Terrain/G8.tscn")
	var p1 = preload("res://instances/Terrain/P3.tscn")
	
	avilableNumbers = numberOfFloors * 14 #obliczanie ile jest wszystkich platform
	generateElementsArray()
#	generatePlatformFillers() #fillery przejść między ścianą, a platformą
	
	currentFloorPassages = passages.duplicate()
	nextRandomedPassages[0] = 6
	currentFloorPassages.erase(nextRandomedPassages[0])
	nextRandomedPassages[1] = 7
	currentFloorPassages.erase(nextRandomedPassages[1])
	
	for f in numberOfFloors:
		
		currentFloorPassages = passages.duplicate() #losowanie przejść
		if nextRandomedPassages[0] != null: currentFloorPassages.erase(nextRandomedPassages[0])
		if nextRandomedPassages[1] != null: currentFloorPassages.erase(nextRandomedPassages[1])
		randomedPassages[0] = nextRandomedPassages[0]#to jest tak dziwnie zrobione by funkcja generatePlatformDecorationBars
		randomedPassages[1] = nextRandomedPassages[1]#mogla dzialac prawidlowo, generowane są 4 przejscia, 2 na teraz i 2 na kolejna petle
		nextRandomedPassages[0] = currentFloorPassages[randi()%currentFloorPassages.size()]
		currentFloorPassages.erase(nextRandomedPassages[0])
		nextRandomedPassages[1] = currentFloorPassages[randi()%currentFloorPassages.size()]
		currentFloorPassages.erase(nextRandomedPassages[1])
		
		for n in numberOfTerrain:
			if randomedPassages.has(n): #wyszukiwanie przejść
				var instanitedP = p1.instance()
				instanitedP.set_global_position(Vector2(width - 62.5,height))
				width += 125
				add_child(instanitedP) #losuje grafike platformy
			var platformList = [g1, g1, g1, g2, g3, g3, g3, g4, g4, g5]
			var instanitedG = platformList[randi()%platformList.size()].instance()
			instanitedG.set_global_position(Vector2(width,height)) #ustawianie platform
			width += 250
			addChildHelper(instanitedG,f)
			checkAndGenerateElements(instanitedG,f)
			generatePlatformDecoration(instanitedG, randomedPassages,f)
			generateMonsters(instanitedG,f+1)
			generatePlatformDecorationBars(instanitedG, randomedPassages, nextRandomedPassages, n, f+1)
			numberOfPlatform += 1
		height -= 320 #ustawianie pozycji dla kolejnego rzędu
		width = -1750

func generatePlatformDecoration(platform, passages, f):
	var o1 = preload("res://instances/Terrain/O8.tscn")
	var o2 = preload("res://instances/Terrain/O9.tscn")
	var o3 = preload("res://instances/Terrain/O10.tscn")
	var o4 = preload("res://instances/Terrain/O11.tscn")
	
	var oB1 = preload("res://instances/Terrain/O20.tscn")#duze elementy
	var oB2 = preload("res://instances/Terrain/O21.tscn")
	var oB3 = preload("res://instances/Terrain/O22.tscn")
	var oB4 = preload("res://instances/Terrain/O23.tscn")

	var os0 = preload("res://instances/Terrain/Os5.tscn")
	var os1 = preload("res://instances/Terrain/Os6.tscn")
	var os2 = preload("res://instances/Terrain/Os7.tscn")
	var os3 = preload("res://instances/Terrain/Os8.tscn")
	var os4 = preload("res://instances/Terrain/Os9.tscn")
	var os5 = preload("res://instances/Terrain/Os10.tscn")
	
	var decorationList = [o1,o2,o3,o4,oB1,oB2,oB3,oB4] #lista dekoracji by się nie powtarzały
	var chanceForDecoration = randi()%2 #nic, jedna ozdoba, dwie #CASTLE 3 -> 2
	for n in chanceForDecoration:
		var decoration = decorationList[randi()%decorationList.size()].instance()
		decorationList.erase((decoration))
		var decorationPosition = generatePositionHelper(platform,decoration)
		if randi()%2 == 1: decoration.scale.x = -1
		decoration.set_global_position(decorationPosition)
		addChildHelper(decoration,f)
	
	var decorationWallList = [os0,os1,os2,os3,os4,os5] #ozdoby sciana
	var chancesForDecorationWall = randi()%4 #raz na na 4 razy
	if chancesForDecorationWall == 0:
		var decoration = decorationWallList[randi()%decorationWallList.size()].instance()
		decorationWallList.erase((decoration))
		var decorationPosition = generatePositionHelper(platform, decoration)
		decorationPosition.y -= 75
		if randi()%2 == 1: decoration.scale.x = -1
		decoration.set_global_position(decorationPosition)
		addChildHelper(decoration,f)

#generuje belki i lampy na suficie
func generatePlatformDecorationBars(platform, passages, nextPassages, numberOfCurrentPlatform, numberOfCurrentFloor): #generowanie obiektów które są od pącztku do końca wysokości platformy 
	if passages[0] <= numberOfCurrentPlatform and passages[1] <= numberOfCurrentPlatform: numberOfCurrentPlatform += 1
	if (passages[0] <= numberOfCurrentPlatform or passages[1] <= numberOfCurrentPlatform):
		var firstPassage
		if passages[0] < passages[1]: firstPassage = passages[0]
		else: firstPassage = passages[1]
		if firstPassage < nextPassages[0] and firstPassage < nextPassages[1] and numberOfCurrentPlatform < nextPassages[0] and numberOfCurrentPlatform < nextPassages[1]:
			numberOfCurrentPlatform += 1
	var o7 = preload("res://instances/Terrain/Pillar1.tscn")#belki 
	var o8 = preload("res://instances/Terrain/Pillar2.tscn") 
	var og1 = preload("res://instances/Elements/Lamp3.tscn")#lampy
	var og2 = preload("res://instances/Elements/Lamp4.tscn")
	var chancesForDecoration = randi()%4 #tu zmien czestosc wystepowannia belek
	var decorationCelingList = [og1,og2] #czestość generowania na suficie
	var chancesForDecorationCeling = randi()%4
	if !nextPassages.has(numberOfCurrentPlatform) and numberOfCurrentFloor != numberOfFloors:
		if chancesForDecoration == 1:#obecnie jedna belka znajduje się 1/3 w platformie #!może trzeba zmniejszyć tą liczbę
			var decoration
			if randi()%2 == 0: decoration = o7.instance()
			else: decoration = o8.instance()
			var positionOfDecoration = generatePositionHelper(platform, decoration)
			decoration.set_global_position(positionOfDecoration)
			addChildHelper(decoration,numberOfCurrentFloor-1)
		
		if chancesForDecorationCeling == 1:
			var decoration = decorationCelingList[randi()%decorationCelingList.size()].instance()
			decorationCelingList.erase(decoration)
			var decorationPosition = generatePositionHelper(platform, decoration)
			decorationPosition.y += decoration.texture.get_height()
			decorationPosition.y += 55
			decorationPosition.y -= 320
			decoration.set_global_position(decorationPosition)
			addChildHelper(decoration,numberOfCurrentFloor-1)

func generateMonsters(platform,numberOfCurrentFloor):
	var slime4 = preload("res://instances/Monsters/Monster-PurpleSlime.tscn")
	var bat3 = preload("res://instances/Monsters/Monster-Bat4.tscn")
	var ghost = preload("res://instances/Monsters/Monster-Ghost.tscn")
	var skeleton = preload("res://instances/Monsters/Monster-Skeleton.tscn")
	var mage = preload("res://instances/Monsters/Monster-Mage.tscn")
	var iceGolem = preload("res://instances/Monsters/Monster-IceGolem.tscn")
	var mimic = preload("res://instances/Monsters/Monster-Chest.tscn")
	
	var monsterList1 = [slime4,slime4,bat3,bat3,ghost,ghost,ghost,skeleton,skeleton,skeleton,skeleton,mage,mage,iceGolem,iceGolem,mimic]
	var monsterList2 = [slime4]
	
	var numberOfMonster = randi()%3# od 0 do 2 potworków na platformę # tu można to zmienić
	for i in numberOfMonster:
		var generatedMonster
		var list1 = monsterList1
		var list2 = monsterList2
		if  numberOfCurrentFloor <= 7: 
			generatedMonster = list1[randi()%list1.size()].instance()
			list1.erase(generatedMonster)
		if numberOfCurrentFloor > 7 and numberOfCurrentFloor <= 12: 
			generatedMonster = list2[randi()%list2.size()].instance()
			list2.erase(generatedMonster)
		
		var monsterPosition = generatePositionHelper(platform, generatedMonster.get_child(0))
		if generatedMonster.flying == true: monsterPosition.y -= (randi()%200 + 40)
		
		generatedMonster.set_global_position(monsterPosition)
		addChildHelper(generatedMonster,numberOfCurrentFloor-1)

func generateElementsArray(): #Tu zmieniamy liczbę elementów wygenerowanych
	generateElementsArrayHelp(fountainList,[1,3 + playerStats.spawnMoreFountains]) #generowanie fotan, ich liczba !
	generateElementsArrayHelp(anvilList,[1,1])
	generateElementsArrayHelp(trapList,[3,5])
	generateElementsArrayHelp(itemTableList,[1,2])
	generateElementsArrayHelp(chestList,[1,3])
	generateElementsArrayHelp(shopList,[1,1])

func generateElementsArrayHelp(listType,numberOfPossibleElements): #zakres ilości możliwych elementów, i tablica do której wsadzamy
	var numberOfElements = randi()%(numberOfPossibleElements[1]-numberOfPossibleElements[0]+1)
	numberOfElements += numberOfPossibleElements[0]
	for a in numberOfElements:
		var element = randi()%(avilableNumbers/2)# dla 1 połowy planszy
		while avilableList.has(element): element = randi()%(avilableNumbers/2)
		listType.push_front(element)
		avilableList.push_front(element)
	numberOfElements = randi()%(numberOfPossibleElements[1]-numberOfPossibleElements[0]+1)
	numberOfElements += numberOfPossibleElements[0]
	for a in numberOfElements:
		var element = (randi()%(avilableNumbers/2) + (avilableNumbers/2))# dla 2 połowy planszy
		while avilableList.has(element): element = (randi()%(avilableNumbers/2) + (avilableNumbers/2))
		listType.push_front(element)
		avilableList.push_front(element)

func checkAndGenerateElements(platform, numberOrFloor):
	if avilableList.has(numberOfPlatform): #sprawdzanie czy element na platformie i jaki
		if fountainList.has(numberOfPlatform): generateFountain(platform,numberOrFloor)
		if anvilList.has(numberOfPlatform): generateAnvil(platform,numberOrFloor)
		if trapList.has(numberOfPlatform): generateTrap(platform,numberOrFloor)
		if itemTableList.has(numberOfPlatform): generateItemTable(platform,numberOrFloor)
		if chestList.has(numberOfPlatform): generateChest(platform,numberOrFloor)
		if shopList.has(numberOfPlatform): generateShop(platform,numberOrFloor)

func generateFountain(platform,numberOrFloor): #generowanie poszczególnych elementów
	var fountain = preload("res://instances/Elements/Fontain.tscn").instance()
	var positionOfFountain = generatePositionHelper(platform, fountain)
	positionOfFountain.y -= 40
	fountain.set_global_position(positionOfFountain)
	addChildHelper(fountain,numberOrFloor)

func generateAnvil(platform,numberOrFloor):
	var anvil = preload("res://instances/Elements/Anvil.tscn").instance()
	var positionOfAnvil = generatePositionHelper(platform, anvil)
	anvil.set_global_position(positionOfAnvil)
	addChildHelper(anvil,numberOrFloor)

func generateTrap(platform,numberOrFloor):
	var trap = preload("res://instances/Elements/Trap2.tscn").instance()
	var positionOfTrap = generatePositionHelper(platform, trap)
	trap.set_global_position(positionOfTrap)
	addChildHelper(trap,numberOrFloor)

func generateItemTable(platform,numberOrFloor):
	var table = preload("res://instances/Elements/ItemTable.tscn").instance()
	var generatedWepon
	if numberOfPlatform <= (avilableNumbers/2): generatedWepon = getItemOfTier(firstTierWeponList)
	if numberOfPlatform > (avilableNumbers/2): generatedWepon = getItemOfTier(secondTierWeponList)
	table.get_child(0).add_child(generatedWepon)
	var positionOfTable = generatePositionHelper(platform, table)
	table.set_global_position(positionOfTable)
	addChildHelper(table,numberOrFloor)

func generateChest(platform,numberOrFloor):
	var chest = preload("res://instances/Elements/ChestGolden.tscn").instance()
	var generatedItem # ! To Do
	if numberOfPlatform <= (avilableNumbers/2): generatedItem = getItemOfTier(firstTierPotion,true)
	if numberOfPlatform > (avilableNumbers/2): generatedItem = getItemOfTier(secondTierPotion,true)
	chest.add_child(generatedItem)
	var positionOfChest = generatePositionHelper(platform, chest)
	chest.set_global_position(positionOfChest)
	addChildHelper(chest,numberOrFloor)

func generateShop(platform,numberOrFloor):
	var shop = preload("res://instances/Elements/Door.tscn").instance()
	var generatedItems = [] # ! To Do
	
	if numberOfPlatform <= (avilableNumbers/2):
		for a in 3:
			var chanceForItem = randi()%10
			if chanceForItem < 4: #bron
				generatedItems.push_back(getItemOfTier(firstTierWeponList,true))
			if chanceForItem >= 4 and chanceForItem != 9: 
				generatedItems.push_back(getItemOfTier(firstTierPotion,true))
			if chanceForItem == 9:
				generatedItems.push_back(getItemOfTier(SpecialTierList,true))
	if numberOfPlatform > (avilableNumbers/2):
		for a in 3:
			var chanceForItem = randi()%10
			if chanceForItem < 4: #itemy
				generatedItems.push_back(getItemOfTier(secondTierWeponList,true))
			if chanceForItem >= 4 and chanceForItem != 9: 
				generatedItems.push_back(getItemOfTier(secondTierPotion,true))
			if chanceForItem == 9:
				generatedItems.push_back(getItemOfTier(SpecialTierList,true))
	
	shop.get_node("ItemSlot1").add_child(generatedItems[0])
	shop.get_node("ItemSlot2").add_child(generatedItems[1])
	shop.get_node("ItemSlot3").add_child(generatedItems[2])
	
	
	var positionOfChest = generatePositionHelper(platform, shop)
	shop.set_global_position(positionOfChest)
	addChildHelper(shop,numberOrFloor)

func generatePositionHelper(platform, object):
	var height = platform.global_position.y - 35 #35 to połowa wysokości platformy
	height = height - object.texture.get_height() / 2
	var width = 0
	if object is monsterClass: width = rand_range((platform.global_position.x + (object.texture.get_width()) - (platform.texture.get_width() / 2)), platform.global_position.x - (object.texture.get_width()) + (platform.texture.get_width() / 2))
	else: width = rand_range((platform.global_position.x + ((object.texture.get_width() / 2)/object.hframes) - (platform.texture.get_width() / 2)), platform.global_position.x - ((object.texture.get_width() / 2)/object.hframes) + (platform.texture.get_width() / 2))
	return Vector2(width,height) #	var width = rand_range(platform.global_position.x - (object.texture.get_width() / 2), platform.global_position.x + (object.texture.get_width() / 2 ))

func getItemOfTier(listOfTier,notDelete = false):
	var randomedItem = listOfTier[randi()%listOfTier.size()].instance()
	if !notDelete: listOfTier.erase(randomedItem)
	return randomedItem

func addChildHelper(object,currentFloor):
	if currentFloor < 2:
		$Stage1.add_child(object)
		return
	if currentFloor < 4 and currentFloor > 1:
		$Stage2.add_child(object)
		return
	if currentFloor < 6 and currentFloor > 3:
		$Stage3.add_child(object)
		return
	if currentFloor < 8 and currentFloor > 5:
		$Stage4.add_child(object)
		return
	if currentFloor < 10 and currentFloor > 7:
		$Stage5.add_child(object)
		return
	if currentFloor < 12 and currentFloor > 9:
		$Stage6.add_child(object)
		return
