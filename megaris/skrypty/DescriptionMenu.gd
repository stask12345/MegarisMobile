extends Node2D

var itemDescription

func _ready():
	pass

func showDescription(itemToShow):
	itemDescription = itemToShow
	$ItemImage.texture = itemDescription.texture
	if itemDescription is item: 
		$ItemImage.scale.x = 1
		$ItemImage.scale.y = 1
	else: 
		$ItemImage.scale.x = 2
		$ItemImage.scale.y = 2
	$Title.text = itemDescription.title
	if itemDescription is item: $Description.text = itemDescription.description
	if itemDescription is wepon: 
		$Description.text = "Damage: " + String(itemDescription.minDamage) + " - " + String(itemDescription.maxDamage) + "\nRange: " + String(itemDescription.bulletRange*100) + "\nFire Speed: " + String(itemDescription.fireSpeed)
	visible = true

func hideDescription():
	visible = false
