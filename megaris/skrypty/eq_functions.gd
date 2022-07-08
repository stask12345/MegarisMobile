extends CanvasLayer

onready var weponHolder = get_node("Control4/WeponHolder")
onready var inventory1 = get_node("Control5/Slot1_b")
onready var inventory2 = get_node("Control5/Slot2_b")
onready var inventory3 = get_node("Control5/Slot3_b")
onready var inventoryDeleteSlot = get_node("Control5/SlotDelete")
onready var inventory1Animation = get_node("Control5/Slot1_anim")
onready var inventory2Animation = get_node("Control5/Slot2_anim")
onready var inventory3Animation = get_node("Control5/Slot3_anim")
onready var descriptionMenu = get_node("Control4/DescriptionMenu")
onready var inventoryDeleteSlotAnimation = get_node("Control5/SlotDelete_anim")
var selectedSlot = ""
var showDescription = false
var showedDescription = false
var recentlyClicked = false

func pickUpItem(itemToEquip,PlaceTodeleteItemFrom,ScriptTodeleteItemFrom): #gdy nie wiemy jaki typ i czy już mamy broń
	if weponHolder.get_child_count() == 0 and itemToEquip is wepon:
		equipWeapon(itemToEquip,PlaceTodeleteItemFrom,ScriptTodeleteItemFrom)
	else: 
		putInInventory(itemToEquip,PlaceTodeleteItemFrom,ScriptTodeleteItemFrom)

func equipWeapon(itemToEquip,PlaceTodeleteItemFrom,ScriptTodeleteItemFrom): #tu są podstawowe funkcje zarządzające inventory
	if itemToEquip is wepon:
		if ScriptTodeleteItemFrom: ScriptTodeleteItemFrom.itemInScript = null
		if PlaceTodeleteItemFrom: PlaceTodeleteItemFrom.remove_child(itemToEquip)
		weponHolder.add_child(itemToEquip)
		weponHolder.equipWepon()

func putInInventory(itemToEquip,PlaceTodeleteItemFrom,ScriptTodeleteItemFrom):
	var freeInventorySlot = null
	if inventory3.get_child_count() < 2: freeInventorySlot = inventory3
	if inventory2.get_child_count() < 2: freeInventorySlot = inventory2
	if inventory1.get_child_count() < 2: freeInventorySlot = inventory1
	if freeInventorySlot:
		if ScriptTodeleteItemFrom: ScriptTodeleteItemFrom.itemInScript = null
		if PlaceTodeleteItemFrom: PlaceTodeleteItemFrom.remove_child(itemToEquip)
		freeInventorySlot.add_child(itemToEquip)

func _on_Slot1_released():
	showDescription = false
	descriptionMenu.hideDescription()
	
	if inventory1.get_child_count() > 1:
		if !showedDescription:
			if recentlyClicked and selectedSlot == "slot1":
				if inventory1.get_child(1) is item and inventory1.get_child(1).usable:
					inventory1.get_child(1).use()
					_on_background_unselect_button_pressed()
					return
				if inventory1.get_child(1) is wepon:
					switchItemPlace(weponHolder,true)
					weponHolder.equipWepon()
					return
			stopSlotAnimation()
			inventoryDeleteSlot.visible = true
			inventory1Animation.play("highlight_slot")
			selectedSlot = "slot1"
		recentlyClicked = true
		yield(get_tree().create_timer(0.5),"timeout")
		recentlyClicked = false
	else: 
		if selectedSlot != "":
			if inventory1.get_child_count() == 1: switchItemPlace(inventory1)
			else: switchItemPlace(inventory1,true)

func _on_Slot2_released():
	showDescription = false
	descriptionMenu.hideDescription()
	
	if inventory2.get_child_count() > 1:
		if !showedDescription:
			if  recentlyClicked and selectedSlot == "slot2":
				if inventory2.get_child(1) is item and inventory2.get_child(1).usable:
					inventory2.get_child(1).use()
					_on_background_unselect_button_pressed()
					return
				if inventory2.get_child(1) is wepon:
					switchItemPlace(weponHolder,true)
					weponHolder.equipWepon()
					return
			stopSlotAnimation()
			inventoryDeleteSlot.visible = true
			inventory2Animation.play("highlight_slot")
			selectedSlot = "slot2"
		recentlyClicked = true
		yield(get_tree().create_timer(0.5),"timeout")
		recentlyClicked = false
	else:
		if selectedSlot != "":
			if inventory2.get_child_count() == 1: switchItemPlace(inventory2)
			else: switchItemPlace(inventory2,true)

func _on_Slot3_released():
	showDescription = false
	descriptionMenu.hideDescription()
	
	if inventory3.get_child_count() > 1:
		if !showedDescription:
			if recentlyClicked and selectedSlot == "slot3":
				if inventory3.get_child(1) is item and inventory3.get_child(1).usable:
					inventory3.get_child(1).use()
					_on_background_unselect_button_pressed()
					return
				if inventory3.get_child(1) is wepon:
					switchItemPlace(weponHolder,true)
					weponHolder.equipWepon()
					return
			stopSlotAnimation()
			inventoryDeleteSlot.visible = true
			inventory3Animation.play("highlight_slot")
			selectedSlot = "slot3"
		recentlyClicked = true
		yield(get_tree().create_timer(0.5),"timeout")
		recentlyClicked = false
	else:
		if selectedSlot != "":
			if inventory3.get_child_count() == 1: switchItemPlace(inventory3)
			else: switchItemPlace(inventory3,true)

func _on_SlotDeleteButton_pressed():
	if inventoryDeleteSlot.get_child_count() > 1:
		inventoryDeleteSlotAnimation.play("highlight_slot")
		selectedSlot = "slotDelete"
	else:
		if selectedSlot != "":
			if inventoryDeleteSlot.get_child_count() == 1: switchItemPlace(inventoryDeleteSlot)
			else: switchItemPlace(inventoryDeleteSlot,true)

func switchItemPlace(inventoryToAdd,replace = false):
	var selectedinventory
	if selectedSlot == "slot1": selectedinventory = inventory1
	if selectedSlot == "slot2": selectedinventory = inventory2
	if selectedSlot == "slot3": selectedinventory = inventory3
	if selectedSlot == "slotDelete": selectedinventory = inventoryDeleteSlot
	var selectedItem = selectedinventory.get_child(1)
	if replace:
		var item1
		if inventoryToAdd.get_child_count() > 1: item1 = inventoryToAdd.get_child(1)
		if inventoryToAdd.get_child_count() > 0: item1 = inventoryToAdd.get_child(0)
		if inventoryToAdd.get_child_count() == 0: item1 = null
		if item1 != null:
			inventoryToAdd.remove_child(item1)
			selectedinventory.add_child(item1)
	selectedinventory.remove_child(selectedItem)
	inventoryToAdd.add_child(selectedItem)
	stopSlotAnimation()

func stopSlotAnimation():
	inventory1.modulate = Color.white
	inventory1Animation.stop()
	inventory2.modulate = Color.white
	inventory2Animation.stop()
	inventory3.modulate = Color.white
	inventory3Animation.stop()
	selectedSlot = ""


func _on_background_unselect_button_pressed():
	if inventoryDeleteSlot.get_child_count() > 1:
		inventoryDeleteSlot.get_child(1).queue_free()
	inventoryDeleteSlot.visible = false
	stopSlotAnimation()


func _on_Button_wepon_pressed():
	if selectedSlot != "":
		var selectedinventory
		if selectedSlot == "slot1": selectedinventory = inventory1
		if selectedSlot == "slot2": selectedinventory = inventory2
		if selectedSlot == "slot3": selectedinventory = inventory3
		var selectedItem = selectedinventory.get_child(1)
		if selectedItem is wepon:
			switchItemPlace(weponHolder,true)
			weponHolder.equipWepon()



#pokazywanie opisu
func _on_Slot1_pressed():
	if inventory1.get_child_count() > 1:
		showedDescription = false
		showDescription = true
		yield(get_tree().create_timer(0.3),"timeout")
		if showDescription == true: 
			descriptionMenu.showDescription(inventory1.get_child(1))
			showedDescription = true

func _on_Slot2_pressed():
	if inventory2.get_child_count() > 1:
		showedDescription = false
		showDescription = true
		yield(get_tree().create_timer(0.3),"timeout")
		if showDescription == true: 
			descriptionMenu.showDescription(inventory2.get_child(1))
			showedDescription = true

func _on_Slot3_pressed():
	if inventory3.get_child_count() > 1:
		showedDescription = false
		showDescription = true
		yield(get_tree().create_timer(0.3),"timeout")
		if showDescription == true: 
			descriptionMenu.showDescription(inventory3.get_child(1))
			showedDescription = true


func _on_Button_wepon_button_down():
	if weponHolder.get_child_count() > 0:
		showedDescription = false
		showDescription = true
		yield(get_tree().create_timer(0.3),"timeout")
		if showDescription == true: 
			descriptionMenu.showDescription(weponHolder.get_child(0))
			showedDescription = true


func _on_Button_wepon_button_up():
	showDescription = false
	descriptionMenu.hideDescription()

func makeUIVisible():
	$Control.visible = true
	$Control2.visible = true
	$Control3.visible = true
	$Control4.visible = true
	$Control5.visible = true

func makeUIInVisible():
	$Control.visible = false
	$Control2.visible = false
	$Control3.visible = false
	$Control4.visible = false
	$Control5.visible = false
	get_node("Control/Joystick/TouchScreenButton").position = Vector2(-27.333,-28)
	get_node("Control2/JoystickAttack/TouchScreenButton").position = Vector2(-27.333,-28)
