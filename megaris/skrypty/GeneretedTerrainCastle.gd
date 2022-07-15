extends Node

var avilableList = [] #przechowuje wygenerowane numery wszystkich elentów by się nie powtarzały
var anvilList = [] #przechowuje numer platformy na ktorej ma sie wygenerowac dany element
var shopList = []
var fountainList = []
var trapList = []
var chestList = []
var itemTableList = []
var avilableNumbers #numery wszystkich platform
var numberOfPlatform = 1

var sword1 = preload("res://instances/Wepons/Sword1.tscn")
var sword2 = preload("res://instances/Wepons/Sword2.tscn")
var sword3 = preload("res://instances/Wepons/Sword3.tscn")
var spear1 = preload("res://instances/Wepons/Spear1.tscn")
var spear2 = preload("res://instances/Wepons/Spear2.tscn")
var mace1 = preload("res://instances/Wepons/Mace0.tscn")
var mace2 = preload("res://instances/Wepons/Mace1.tscn")
var mace3 = preload("res://instances/Wepons/Mace2.tscn")
var bow1 = preload("res://instances/Wepons/Bow1.tscn")
var bow2 = preload("res://instances/Wepons/Bow2.tscn")
var wand1 = preload("res://instances/Wepons/Wand1.tscn")
var wand2 = preload("res://instances/Wepons/Wand2.tscn")

var healingPotion1 = preload("res://instances/Items/PotionHealing1.tscn")
var healingPotion2 = preload("res://instances/Items/PotionHealing2.tscn")
var healingPotion3 = preload("res://instances/Items/PotionHealing3.tscn")
var healthPotion = preload("res://instances/Items/PotionHealth1.tscn")
var invisibilityPotion = preload("res://instances/Items/PotionInvisibility1.tscn")
var StrengthPotion = preload("res://instances/Items/PotionStrength1.tscn")

var firstTierPotion = []
var secondTierPotion = []
var firstTierWeponList = []
var secondTierWeponList = []
var SpecialTierList = []

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
				add_child(instanitedP)
			var randomG = randi()%4 #losuje grafike platformy
			var instanitedG
			if randomG == 0: instanitedG = g1.instance()
			if randomG == 1: instanitedG = g2.instance()
			if randomG == 2: instanitedG = g3.instance()
			if randomG == 3: instanitedG = g4.instance()
			instanitedG.set_global_position(Vector2(width,height)) #ustawianie platform
			width += 250
			add_child(instanitedG)
#			checkAndGenerateElements(instanitedG)
			generatePlatformDecoration(instanitedG, randomedPassages)
#			generateMonsters(instanitedG,f+1)
			generatePlatformDecorationBars(instanitedG, randomedPassages, nextRandomedPassages, n, f+1)
			numberOfPlatform += 1
		height -= 320 #ustawianie pozycji dla kolejnego rzędu
		width = -1750

func generatePlatformDecoration(platform, passages):
	var o1 = preload("res://instances/Terrain/O8.tscn")
	var o2 = preload("res://instances/Terrain/O9.tscn")
	var o3 = preload("res://instances/Terrain/O10.tscn")
	var o4 = preload("res://instances/Terrain/O11.tscn")
	
	var oB1 = preload("res://instances/Terrain/O20.tscn")#duze elementy
	var oB2 = preload("res://instances/Terrain/O21.tscn")#duze elementy
	var oB3 = preload("res://instances/Terrain/O22.tscn")#duze elementy

	var os2 = preload("res://instances/Terrain/Os2.tscn")#kamien sciana1
	var os3 = preload("res://instances/Terrain/Os3.tscn")#kamien sciana2
	var os4 = preload("res://instances/Terrain/Os4.tscn")#kamien sciana3
	var os5 = preload("res://instances/Terrain/Os5.tscn")#pekniecie1
	var os6 = preload("res://instances/Terrain/Os6.tscn")#pekniecie2
	
	var decorationList = [o1,o2,o3,o4,oB1,oB2,oB3] #lista dekoracji by się nie powtarzały
	var chanceForDecoration = randi()%2 #nic, jedna ozdoba, dwie #CASTLE 3 -> 2
	for n in chanceForDecoration:
		var decoration = decorationList[randi()%decorationList.size()].instance()
		decorationList.erase((decoration))
		var decorationPosition = generatePositionHelper(platform,decoration)
		if randi()%2 == 1: decoration.scale.x = -1
		decoration.set_global_position(decorationPosition)
		add_child(decoration)
	
#	var decorationWallList = [os1,os2,os3,os4,os5,os6] #ozdoby sciana
#	var chancesForDecorationWall = randi()%2
#	for n in chancesForDecorationWall:
#		var decoration = decorationWallList[randi()%decorationWallList.size()].instance()
#		decorationWallList.erase((decoration))
#		var decorationPosition = generatePositionHelper(platform, decoration)
#		decorationPosition.y += randi()%25
#		decorationPosition.y -= randi()%100
#		if randi()%2 == 1: decoration.scale.x = -1
#		if randi()%2 == 1: decoration.scale.y = -1
#		decoration.set_global_position(decorationPosition)
#		add_child(decoration)
	

#generuje belki i lampy na suficie
func generatePlatformDecorationBars(platform, passages, nextPassages, numberOfCurrentPlatform, numberOfCurrentFloor): #generowanie obiektów które są od pącztku do końca wysokości platformy 
	if passages[0] <= numberOfCurrentPlatform and passages[1] <= numberOfCurrentPlatform: numberOfCurrentPlatform += 1
	if (passages[0] <= numberOfCurrentPlatform or passages[1] <= numberOfCurrentPlatform):
		var firstPassage
		if passages[0] < passages[1]: firstPassage = passages[0]
		else: firstPassage = passages[1]
		if firstPassage < nextPassages[0] and firstPassage < nextPassages[1] and numberOfCurrentPlatform < nextPassages[0] and numberOfCurrentPlatform < nextPassages[1]:
			numberOfCurrentPlatform += 1
	var o7 = preload("res://instances/Terrain/pillar1.tscn")#belki 
	var o8 = preload("res://instances/Terrain/pillar2.tscn") 
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
			add_child(decoration)
		
		if chancesForDecorationCeling == 1:
			var decoration = decorationCelingList[randi()%decorationCelingList.size()].instance()
			decorationCelingList.erase(decoration)
			var decorationPosition = generatePositionHelper(platform, decoration)
			decorationPosition.y += decoration.texture.get_height()
			decorationPosition.y += 55
			decorationPosition.y -= 320
			decoration.set_global_position(decorationPosition)
			add_child(decoration)

func generateMonsters(platform,numberOfCurrentFloor):
	var slime0 = preload("res://instances/Monsters/Monster-Slime.tscn")
	var slime1 = preload("res://instances/Monsters/Monster-OrangeSlime.tscn")
	var slime2 = preload("res://instances/Monsters/Monster-RedSlime.tscn")
	var slime3 = preload("res://instances/Monsters/Monster-BlueSlime.tscn")
	var bat0 = preload("res://instances/Monsters/Monster-Bat3.tscn")
	var bat1 = preload("res://instances/Monsters/Monster-Bat.tscn")
	var bat2 = preload("res://instances/Monsters/Monster-Bat2.tscn")
	var spider = preload("res://instances/Monsters/Monster-Spider.tscn")
	var turtle = preload("res://instances/Monsters/Monster-Turtle.tscn")
	var turtle1 = preload("res://instances/Monsters/Monster-BigTurtle.tscn")
	
	var monsterList0 = [slime0,slime0,bat0]
	var monsterList1 = [slime1,slime1,slime1,bat1,bat1,slime3,turtle]
	var monsterList2 = [slime2,slime2,slime2,bat2,bat2,spider,turtle1,slime3]
	
	var numberOfMonster = randi()%3# od 0 do 2 potworków na platformę # tu można to zmienić
	for i in numberOfMonster:
		var generatedMonster
		var list0 = monsterList0
		var list1 = monsterList1
		var list2 = monsterList2
		if numberOfCurrentFloor <= 2:
			generatedMonster = list0[randi()%list0.size()].instance()
			list0.erase(generatedMonster)
		if  numberOfCurrentFloor > 2 and numberOfCurrentFloor <= 7: 
			generatedMonster = list1[randi()%list1.size()].instance()
			list1.erase(generatedMonster)
		if numberOfCurrentFloor > 7 and numberOfCurrentFloor <= 12: 
			generatedMonster = list2[randi()%list2.size()].instance()
			list2.erase(generatedMonster)
		
		var monsterPosition = generatePositionHelper(platform, generatedMonster.get_child(0))
		if generatedMonster.flying == true: monsterPosition.y -= (randi()%200 + 40)
		
		generatedMonster.set_global_position(monsterPosition)
		add_child(generatedMonster)

func generateElementsArray(): #Tu zmieniamy liczbę elementów wygenerowanych
	generateElementsArrayHelp(fountainList,[1,3]) #generowanie fotan, ich liczba !
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

func checkAndGenerateElements(platform):
	if avilableList.has(numberOfPlatform): #sprawdzanie czy element na platformie i jaki
		if fountainList.has(numberOfPlatform): generateFountain(platform)
		if anvilList.has(numberOfPlatform): generateAnvil(platform)
		if trapList.has(numberOfPlatform): generateTrap(platform)
		if itemTableList.has(numberOfPlatform): generateItemTable(platform)
		if chestList.has(numberOfPlatform): generateChest(platform)
		if shopList.has(numberOfPlatform): generateShop(platform)

func generateFountain(platform): #generowanie poszczególnych elementów
	var fountain = preload("res://instances/Elements/Fontain.tscn").instance()
	var positionOfFountain = generatePositionHelper(platform, fountain)
	positionOfFountain.y -= 40
	fountain.set_global_position(positionOfFountain)
	add_child(fountain)

func generateAnvil(platform):
	var anvil = preload("res://instances/Elements/Anvil.tscn").instance()
	var positionOfAnvil = generatePositionHelper(platform, anvil)
	anvil.set_global_position(positionOfAnvil)
	add_child(anvil)

func generateTrap(platform):
	var trap = preload("res://instances/Elements/Trap1.tscn").instance()
	var positionOfTrap = generatePositionHelper(platform, trap)
	trap.set_global_position(positionOfTrap)
	add_child(trap)

func generateItemTable(platform):
	var table = preload("res://instances/Elements/ItemTable.tscn").instance()
	var generatedWepon
	if numberOfPlatform <= (avilableNumbers/2): generatedWepon = getItemOfTier(firstTierWeponList)
	if numberOfPlatform > (avilableNumbers/2): generatedWepon = getItemOfTier(secondTierWeponList)
	table.get_child(0).add_child(generatedWepon)
	var positionOfTable = generatePositionHelper(platform, table)
	table.set_global_position(positionOfTable)
	add_child(table)

func generateChest(platform):
	var chest = preload("res://instances/Elements/Chest.tscn").instance()
	var generatedItem # ! To Do
	if numberOfPlatform <= (avilableNumbers/2): generatedItem = getItemOfTier(firstTierPotion,true)
	if numberOfPlatform > (avilableNumbers/2): generatedItem = getItemOfTier(secondTierPotion,true)
	chest.add_child(generatedItem)
	var positionOfChest = generatePositionHelper(platform, chest)
	chest.set_global_position(positionOfChest)
	add_child(chest)

func generateShop(platform):
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
	add_child(shop)

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

#func generatePlatformFillers():
#	var filler = preload("res://instances/Terrain/filler-platform.tscn")
#	var heightOfFiller = 805
#	for r in numberOfFloors+1:
#		var f = filler.instance()
#		var f1 = filler.instance()
#		f.global_position = Vector2(-1877.15,heightOfFiller)
#		f1.global_position = Vector2(1877.8,heightOfFiller)
#		add_child(f)
#		add_child(f1)
#		heightOfFiller -= 320
