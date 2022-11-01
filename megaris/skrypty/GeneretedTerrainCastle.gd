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
var specialSword = preload("res://instances/Wepons/SpecialSword1.tscn")
var specialWand = preload("res://instances/Wepons/SpecialWand3.tscn")

var firstTierPotion = [healingPotion3,healingPotion3,healthPotion,invisibilityPotion,scroolFireBall]
var secondTierPotion = [healingPotion4,healingPotion4,healthPotion,invisibilityPotion,StrengthPotion,scroolExplosion]
var firstTierWeponList = [sword4,spear3,mace3,bow3,wand3,sword4,spear3,mace3,bow3,wand3,sword4,spear3,mace3,bow3,wand3,sword4,spear3,mace3,bow3,wand3,specialWand]
var secondTierWeponList = [sword5,spear4,mace4,bow4,wand4,sword5,spear4,mace4,bow4,wand4,sword5,spear4,mace4,bow4,wand4,sword5,spear4,mace4,bow4,wand4,specialSword]
var SpecialTierList = [specialWand,specialSword,scroolExplosion,wand4]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	if !get_node("/root/MainScene/EffectGenerator").loadedData: 
		generateWorld()
		saveTerrain()
	if get_node("/root/MainScene/EffectGenerator").loadedData: 
		print("GWIAZDA")
		get_node("/root/MainScene").loadDataCurrent()
		loadWorld()

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
				addChildHelper(instanitedP,f) #losuje grafike platformy
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
	
	var decorationList #lista dekoracji by się nie powtarzały
	if fountainList.has(numberOfPlatform) or anvilList.has(numberOfPlatform) or shopList.has(numberOfPlatform):
		decorationList = [o1,o2,o3,o4]
	else:
		decorationList = [o1,o2,o3,o4,oB1,oB2,oB3,oB4]
	var chanceForDecoration = randi()%2 #nic, jedna ozdoba, dwie #CASTLE 3 -> 2
	for n in chanceForDecoration:
		var decoration = decorationList[randi()%decorationList.size()].instance()
		decorationList.erase((decoration))
		var decorationPosition = generatePositionHelper(platform,decoration)
		if randi()%2 == 1: decoration.scale.x = -1
		decoration.set_global_position(decorationPosition)
		addChildHelper(decoration,f)
	
	var decorationWallList #ozdoby sciana
	var chancesForDecorationWall = randi()%4 #raz na na 4 razy
	if fountainList.has(numberOfPlatform) or anvilList.has(numberOfPlatform) or shopList.has(numberOfPlatform):
		decorationWallList = [os0,os1,os3,os4,os5]
	else:
		decorationWallList = [os0,os1,os2,os3,os4,os5]
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
	var og3 = preload("res://instances/Terrain/Baner1.tscn")
	var og4 = preload("res://instances/Terrain/Baner2.tscn")
	var og5 = preload("res://instances/Terrain/Baner3.tscn")
	var chancesForDecoration = randi()%4 #tu zmien czestosc wystepowannia belek
	var decorationCelingList = [og1,og2,og3,og4,og5] #czestość generowania na suficie
	var chancesForDecorationCeling = randi()%3 # gdy za dużo na suficie to "4"
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
			decorationPosition.y += 59
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
	var worm = preload("res://instances/Monsters/Monster-Worm.tscn")
	
	var slime5 = preload("res://instances/Monsters/Monster-GoldenSlime.tscn")
	var bat4 = preload("res://instances/Monsters/Monster-Bat5.tscn")
	var ghost1 = preload("res://instances/Monsters/Monster-Ghost2.tscn")
	var skeleton1 = preload("res://instances/Monsters/Monster-SkeletonWarrior.tscn")
	var mage1 = preload("res://instances/Monsters/Monster-Mage2.tscn")
	var fireGolem = preload("res://instances/Monsters/Monster-FireGolem.tscn")
	var worm1 = preload("res://instances/Monsters/Monster-Worm2.tscn")
	var turtle = preload("res://instances/Monsters/Monster-GiganticTurtle.tscn")
	
	var monsterList1 = [slime4,slime4,bat3,bat3,ghost,ghost,ghost,skeleton,skeleton,skeleton,skeleton,mage,mage,worm,worm,iceGolem,iceGolem, slime4,slime4,bat3,bat3,ghost,ghost,ghost,skeleton,skeleton,skeleton,skeleton,mage,mage,worm,worm,iceGolem,iceGolem,mimic]
	var monsterList2 = [turtle,turtle,turtle,turtle,slime5,slime5,bat4,bat4,ghost1,ghost1,skeleton1,skeleton1,mage1,mage1,worm1,worm1,fireGolem,fireGolem, slime5,slime5,bat4,bat4,ghost1,ghost1,skeleton1,skeleton1,mage1,mage1,worm1,worm1,fireGolem,fireGolem, mimic]
	
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


func saveTerrain():
	var save_game = File.new()
	save_game.open("user://savegameTerrain.save", File.WRITE)
	
	for t in $Stage1.get_children():
		if t.is_in_group("saveGroupTerrain"):
			var node_data = {
				"filename": t.filename,
				"pos_x": t.position.x,
				"pos_y": t.position.y,
				"parentPath": t.get_parent().get_path()
			}
			save_game.store_line(to_json(node_data))
	
	for t in $Stage2.get_children():
		if t.is_in_group("saveGroupTerrain"):
			var node_data = {
				"filename": t.filename,
				"pos_x": t.position.x,
				"pos_y": t.position.y,
				"parentPath": t.get_parent().get_path()
			}
			save_game.store_line(to_json(node_data))
	
	for t in $Stage3.get_children():
		if t.is_in_group("saveGroupTerrain"):
			var node_data = {
				"filename": t.filename,
				"pos_x": t.position.x,
				"pos_y": t.position.y,
				"parentPath": t.get_parent().get_path()
			}
			save_game.store_line(to_json(node_data))
	
	for t in $Stage4.get_children():
		if t.is_in_group("saveGroupTerrain"):
			var node_data = {
				"filename": t.filename,
				"pos_x": t.position.x,
				"pos_y": t.position.y,
				"parentPath": t.get_parent().get_path()
			}
			save_game.store_line(to_json(node_data))
	
	for t in $Stage5.get_children():
		if t.is_in_group("saveGroupTerrain"):
			var node_data = {
				"filename": t.filename,
				"pos_x": t.position.x,
				"pos_y": t.position.y,
				"parentPath": t.get_parent().get_path()
			}
			save_game.store_line(to_json(node_data))
	
	for t in $Stage6.get_children():
		if t.is_in_group("saveGroupTerrain"):
			var node_data = {
				"filename": t.filename,
				"pos_x": t.position.x,
				"pos_y": t.position.y,
				"parentPath": t.get_parent().get_path()
			}
			save_game.store_line(to_json(node_data))
	save_game.close()

func saveElements():
	get_node("/root/MainScene/CanvasLayer/Control4/ShopMenu").returnItemsToShopObject()
	get_node("/root/MainScene/CanvasLayer/Control4/ShopMenu").visible = false
	
	var save_game = File.new()
	save_game.open("user://savegameElements.save", File.WRITE)
	
	for t in $Stage1.get_children() + $Stage2.get_children() + $Stage3.get_children() + $Stage4.get_children() + $Stage5.get_children() + $Stage6.get_children():
		if t.name == "Fontain":
			var node_data = {
				"type": "fontain",
				"filename": t.filename,
				"pos_x": t.position.x,
				"pos_y": t.position.y,
				"parentPath": t.get_parent().get_path(),
				"full": t.full
			}
			save_game.store_line(to_json(node_data))
		
		if t.name == "Chest" or t.name == "ChestGolden":
			var node_data = {
				"type": "chest",
				"filename": t.filename,
				"pos_x": t.position.x,
				"pos_y": t.position.y,
				"parentPath": t.get_parent().get_path(),
				"item": t.getItem()
			}
			save_game.store_line(to_json(node_data))
		
		if t.name == "Anvil":
			var node_data = {
				"type": "anvil",
				"filename": t.filename,
				"pos_x": t.position.x,
				"pos_y": t.position.y,
				"parentPath": t.get_parent().get_path()
			}
			save_game.store_line(to_json(node_data))
		
		if t.name == "ItemTable":
			var node_data = {
					"type": "itemTable",
					"filename": t.filename,
					"pos_x": t.position.x,
					"pos_y": t.position.y,
					"parentPath": t.get_parent().get_path(),
					"item": t.getItem()
				}
			save_game.store_line(to_json(node_data))
		
		if t.name == "Trap1" or t.name == "Trap2":
			var node_data = {
					"type": "trap",
					"filename": t.filename,
					"pos_x": t.position.x,
					"pos_y": t.position.y,
					"parentPath": t.get_parent().get_path(),
					"used": t.used
				}
			save_game.store_line(to_json(node_data))
		
		if t.name == "Door":
			var node_data = {
					"type": "shop",
					"filename": t.filename,
					"pos_x": t.position.x,
					"pos_y": t.position.y,
					"parentPath": t.get_parent().get_path(),
					"item1": t.getItem1(),
					"item2": t.getItem2(),
					"item3": t.getItem3()
				}
			save_game.store_line(to_json(node_data))
	
	save_game.close()

func saveMonsters():
	var save_game = File.new()
	save_game.open("user://savegameMonsters.save", File.WRITE)
	
	for t in $Stage1.get_children() + $Stage2.get_children() + $Stage3.get_children() + $Stage4.get_children() + $Stage5.get_children() + $Stage6.get_children():
		if t is monsterClass:
			var node_data = {
				"filename": t.filename,
				"pos_x": t.position.x,
				"pos_y": t.position.y,
				"parentPath": t.get_parent().get_path()
			}
			save_game.store_line(to_json(node_data))
	
	save_game.close()

func loadWorld():
	#get_node("/root/MainScene").loadDataCurrent()
	loadTerrain()
	loadElements()
	loadMonsters()

func loadTerrain():
	var save_game = File.new()
	if not save_game.file_exists("user://savegameTerrain.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://savegameTerrain.save", File.READ)
	while save_game.get_position() < save_game.get_len():#obiektów do skopiowania
		var node_data = parse_json(save_game.get_line())
		var o = load(node_data["filename"]).instance()
		get_node(node_data["parentPath"]).add_child(o)
		o.position = Vector2(node_data["pos_x"],node_data["pos_y"])
	save_game.close()

func loadMonsters():
	var save_game = File.new()
	if not save_game.file_exists("user://savegameMonsters.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://savegameMonsters.save", File.READ)
	while save_game.get_position() < save_game.get_len():
		var node_data = parse_json(save_game.get_line())
		var m =load(node_data["filename"]).instance()
		get_node(node_data["parentPath"]).add_child(m)
		m.position = Vector2(node_data["pos_x"],node_data["pos_y"])
	save_game.close()

func loadElements():
	var save_game = File.new()
	if not save_game.file_exists("user://savegameElements.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://savegameElements.save", File.READ)
	while save_game.get_position() < save_game.get_len():#obiektów do skopiowania
		var node_data = parse_json(save_game.get_line())
		var o = load(node_data["filename"]).instance()
		o.position = Vector2(node_data["pos_x"],node_data["pos_y"])
		
		if node_data["type"] == "fontain":
			if node_data["full"] == false:
				o.makeEmpty()
		
		if node_data["type"] == "chest":
			if node_data["item"] != null:
				var i = load(node_data["item"]).instance()
				o.add_child(i)
			else:
				o.emptyChest()
		
		if node_data["type"] == "itemTable":
			if node_data["item"] != null:
				var i = load(node_data["item"]).instance()
				o.get_child(0).add_child(i)
		
		if node_data["type"] == "trap":
			if node_data["used"] == true:
				o.makeUsed()
		
		if node_data["type"] == "shop":
			var i
			if node_data["item1"] != null:
				i = load(node_data["item1"]).instance()
				o.get_node("ItemSlot1").add_child(i)
			if node_data["item2"] != null:
				i = load(node_data["item2"]).instance()
				o.get_node("ItemSlot2").add_child(i)
			if node_data["item3"] != null:
				i = load(node_data["item3"]).instance()
				o.get_node("ItemSlot3").add_child(i)
		
		get_node(node_data["parentPath"]).add_child(o)
	save_game.close()
