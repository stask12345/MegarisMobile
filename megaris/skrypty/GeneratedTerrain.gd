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

var sword1 = preload("res://instances/Wepons/Sword1.tscn")
var sword2 = preload("res://instances/Wepons/Sword2.tscn")
var sword3 = preload("res://instances/Wepons/Sword3.tscn")
var spear1 = preload("res://instances/Wepons/Spear1.tscn")
var spear2 = preload("res://instances/Wepons/Spear2.tscn")
var mace1 = preload("res://instances/Wepons/Mace1.tscn")
var mace2 = preload("res://instances/Wepons/Mace2.tscn")
var bow1 = preload("res://instances/Wepons/Bow1.tscn")
var bow2 = preload("res://instances/Wepons/Bow2.tscn")
var wand1 = preload("res://instances/Wepons/Wand1.tscn")
var wand2 = preload("res://instances/Wepons/Wand2.tscn")
var special1 = preload("res://instances/Wepons/SpecialWand4.tscn")
var special2 = preload("res://instances/Wepons/SpecialSword2.tscn")

var healingPotion1 = preload("res://instances/Items/PotionHealing1.tscn")
var healingPotion2 = preload("res://instances/Items/PotionHealing2.tscn")
var healingPotion3 = preload("res://instances/Items/PotionHealing3.tscn")
var healthPotion = preload("res://instances/Items/PotionHealth1.tscn")
var invisibilityPotion = preload("res://instances/Items/PotionInvisibility1.tscn")
var StrengthPotion = preload("res://instances/Items/PotionStrength1.tscn")
var scroolExplosion1 = preload("res://instances/Items/SpellExplosion.tscn")
var scroolFireBall1 = preload("res://instances/Items/SpellFireBall.tscn")


var firstTierPotion = [healingPotion1,healthPotion,invisibilityPotion,scroolFireBall1]
var secondTierPotion = [healingPotion2,healthPotion,invisibilityPotion,StrengthPotion,scroolExplosion1]
var firstTierWeponList = [sword2,spear1,mace1,bow1,wand1,sword2,spear1,mace1,bow1,wand1,sword2,spear1,mace1,bow1,wand1,special1]
var secondTierWeponList = [sword3,spear2,mace2,bow2,wand2,sword3,spear2,mace2,bow2,wand2,sword3,spear2,mace2,bow2,wand2,special2]
var SpecialTierList = [wand1,wand2,wand1,wand2,special1,special2,healingPotion3,healingPotion3]

var loadSave = false
var loadCastle = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if loadCastle:
		get_node("/root/MainScene/EffectGenerator").getPlayerToCastleLoad()
	
	randomize()
	if !loadSave and !loadCastle: 
		generateWorld()
		saveTerrain()
	if loadSave and !loadCastle: 
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
	var g1 = preload("res://instances/Terrain/G1.tscn")
	var g2 = preload("res://instances/Terrain/G2.tscn")
	var g3 = preload("res://instances/Terrain/G3.tscn")
	var p1 = preload("res://instances/Terrain/P1.tscn")
	
	avilableNumbers = numberOfFloors * 14 #obliczanie ile jest wszystkich platform
	generateElementsArray()
	generatePlatformFillers() #fillery przejść między ścianą, a platformą
	
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
				addChildHelper(instanitedP,f)
			var randomG = randi()%3 #losuje grafike platformy
			var instanitedG
			if randomG == 0: instanitedG = g1.instance()
			if randomG == 1: instanitedG = g2.instance()
			if randomG == 2: instanitedG = g3.instance()
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

func generatePlatformDecoration(platform, _passages, f):
	var o1 = preload("res://instances/Terrain/O1.tscn")#kamien
	var o2 = preload("res://instances/Terrain/O2.tscn")#trawa
	var o3 = preload("res://instances/Terrain/O3.tscn")#kamien2
	var o4 = preload("res://instances/Terrain/O4.tscn")#grzyb1
	var o5 = preload("res://instances/Terrain/O5.tscn")#grzyb2
	var o6 = preload("res://instances/Terrain/O6.tscn")#grzyb3
	var o7 = preload("res://instances/Elements/Vase.tscn")#waza
	var o8 = preload("res://instances/Elements/Minecart.tscn")#wózek
	var o9 = preload("res://instances/Elements/Box.tscn")#pudełka
	var os1 = preload("res://instances/Terrain/Os1.tscn")#pekniecie
	var os2 = preload("res://instances/Terrain/Os2.tscn")#kamien sciana1
	var os3 = preload("res://instances/Terrain/Os3.tscn")#kamien sciana2
	var os4 = preload("res://instances/Terrain/Os4.tscn")#kamien sciana3
	var os5 = preload("res://instances/Terrain/Os5.tscn")#pekniecie1
	var os6 = preload("res://instances/Terrain/Os6.tscn")#pekniecie2
	
	var decorationList = [o1,o2,o3,o4,o5,o6,o7,o8,o9] #lista dekoracji by się nie powtarzały
	var chanceForDecoration = randi()%3 #nic, jedna ozdoba, dwie
	for n in chanceForDecoration:
		var decoration = decorationList[randi()%decorationList.size()].instance()
		decorationList.erase((decoration))
		var decorationPosition = generatePositionHelper(platform,decoration)
		if randi()%2 == 1: decoration.scale.x = -1
		decoration.set_global_position(decorationPosition)
		addChildHelper(decoration,f)
	
	var decorationWallList = [os1,os2,os3,os4,os5,os6] #ozdoby sciana
	var chancesForDecorationWall = randi()%2
	for n in chancesForDecorationWall:
		var decoration = decorationWallList[randi()%decorationWallList.size()].instance()
		decorationWallList.erase((decoration))
		var decorationPosition = generatePositionHelper(platform, decoration)
		decorationPosition.y += randi()%25
		decorationPosition.y -= randi()%100
		if randi()%2 == 1: decoration.scale.x = -1
		if randi()%2 == 1: decoration.scale.y = -1
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
	var o7 = preload("res://instances/Terrain/O7.tscn")#belka 
	var og1 = preload("res://instances/Elements/Lamp1.tscn")#lampy
	var og2 = preload("res://instances/Elements/Lamp2.tscn")
	var chancesForDecoration = randi()%4 #tu zmien czestosc wystepowannia belek
	var decorationCelingList = [og1,og2] #czestość generowania na suficie
	var chancesForDecorationCeling = randi()%4
	if !nextPassages.has(numberOfCurrentPlatform) and numberOfCurrentFloor != numberOfFloors:
		if chancesForDecoration == 1:#obecnie jedna belka znajduje się 1/3 w platformie #!może trzeba zmniejszyć tą liczbę
			var decoration = o7.instance()
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

func checkAndGenerateElements(platform,f):
	if avilableList.has(numberOfPlatform): #sprawdzanie czy element na platformie i jaki
		if fountainList.has(numberOfPlatform): generateFountain(platform,f)
		if anvilList.has(numberOfPlatform): generateAnvil(platform,f)
		if trapList.has(numberOfPlatform): generateTrap(platform,f)
		if itemTableList.has(numberOfPlatform): generateItemTable(platform,f)
		if chestList.has(numberOfPlatform): generateChest(platform,f)
		if shopList.has(numberOfPlatform): generateShop(platform,f)

func generateFountain(platform,f): #generowanie poszczególnych elementów
	var fountain = preload("res://instances/Elements/Fontain.tscn").instance()
	var positionOfFountain = generatePositionHelper(platform, fountain)
	positionOfFountain.y -= 40
	fountain.set_global_position(positionOfFountain)
	addChildHelper(fountain,f)

func generateAnvil(platform,f):
	var anvil = preload("res://instances/Elements/Anvil.tscn").instance()
	var positionOfAnvil = generatePositionHelper(platform, anvil)
	anvil.set_global_position(positionOfAnvil)
	addChildHelper(anvil,f)

func generateTrap(platform,f):
	var trap = preload("res://instances/Elements/Trap1.tscn").instance()
	var positionOfTrap = generatePositionHelper(platform, trap)
	trap.set_global_position(positionOfTrap)
	addChildHelper(trap,f)

func generateItemTable(platform,f):
	var table = preload("res://instances/Elements/ItemTable.tscn").instance()
	var generatedWepon
	if numberOfPlatform <= (avilableNumbers/2): generatedWepon = getItemOfTier(firstTierWeponList)
	if numberOfPlatform > (avilableNumbers/2): generatedWepon = getItemOfTier(secondTierWeponList)
	table.get_child(0).add_child(generatedWepon)
	var positionOfTable = generatePositionHelper(platform, table)
	table.set_global_position(positionOfTable)
	addChildHelper(table,f)

func generateChest(platform,f):
	var chest = preload("res://instances/Elements/Chest.tscn").instance()
	var generatedItem # ! To Do
	if numberOfPlatform <= (avilableNumbers/2): generatedItem = getItemOfTier(firstTierPotion,true)
	if numberOfPlatform > (avilableNumbers/2): generatedItem = getItemOfTier(secondTierPotion,true)
	chest.add_child(generatedItem)
	var positionOfChest = generatePositionHelper(platform, chest)
	chest.set_global_position(positionOfChest)
	addChildHelper(chest,f)

func generateShop(platform,f):
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
	addChildHelper(shop,f)

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

func generatePlatformFillers():
	var filler = preload("res://instances/Terrain/filler-platform.tscn")
	var heightOfFiller = 805
	for r in numberOfFloors+1:
		var f = filler.instance()
		var f1 = filler.instance()
		f.global_position = Vector2(-1877.15,heightOfFiller)
		f1.global_position = Vector2(1877.8,heightOfFiller)
		add_child(f)
		add_child(f1)
		heightOfFiller -= 320

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

func save():
	var node_data = {
		"loadSave": loadSave,
		"nodePath": get_path()
	}
	return node_data

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
	generatePlatformFillers()

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
