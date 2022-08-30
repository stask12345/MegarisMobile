extends Node2D

var firstStep = false
var secondStep = false
var thirdStep = false
var thirdStepOnce = false
var fifthStep = false
var sixthStep = false
var seventhStep = false
var seventhStep1 = false
var changeColor = false
var dummyDestroyed = false

func _ready():
	get_node("/root/MainScene/CanvasLayer").atTutorial = true
	get_node("/root/MainScene/CanvasLayer").atTutorialUseBlocade = true
	get_node("/root/MainScene/CanvasLayer/Control/Joystick/TouchScreenButton").lockJoyStick = true
	get_node("/root/MainScene/Player").falling = true
#	var camera = get_node("/root/MainScene/Player/Player/Camera2D")
	tutorialFirstStep()

func endFall():
	get_node("/root/MainScene/Player").falling = false
	changeColor = true
	get_node("/root/MainScene/Player/AnimationPlayerJumpEffect").play("jumpEffect")
	get_node("/root/MainScene/CanvasLayer/Control3/Hp").hp -= 30
	get_node("/root/MainScene/CanvasLayer/Control/Joystick/TouchScreenButton").lockJoyStick = false

func endChangeColor():
	changeColor = false
	if changeColor: get_node("/root/MainScene/Player").changeColor(Color.white)

func _process(_delta):
	if firstStep and get_node("/root/MainScene/CanvasLayer/Control/Joystick/TouchScreenButton").get_value() != Vector2(0,0):
		$AnimationPlayer1.play("endingAnimation")
	if secondStep and get_node("Chest").get_child_count() < 3: $AnimationPlayer1.play("endingAnimation1")
	if thirdStep and !thirdStepOnce and get_node("/root/MainScene/CanvasLayer/Control4/DescriptionMenu").visible == true: 
		tutorialFourStep()
		thirdStepOnce = true
	if fifthStep and get_node("/root/MainScene/CanvasLayer/Control5/Slot1_b").get_child_count() < 2: tutorialFifthStep()
	if sixthStep and $ItemTable/KinematicBody2D2.get_child_count() == 0: tutorialSixthStep()
	if seventhStep and get_node("/root/MainScene/CanvasLayer/Control2/JoystickAttack/TouchScreenButton").get_value_attack() != Vector2(0,0):
		tutorialSevenStep()
	if dummyDestroyed and seventhStep1 == true: tutorialSevenStepComplete()
	if changeColor: get_node("/root/MainScene/Player").changeColor(Color.red)

func tutorialFirstStep():
	$AnimationPlayer1.play("startingAnimation")

func tutorialFirstStep1():
	$AnimationPlayer1.play("idle")

func tutorialFirstStepComplete():
	firstStep = true

func tutorialSecondStep():
	firstStep = false
	$AnimationPlayer1.play("startingAnimation1")
	$Transparent3/StaticBody2D/CollisionShape2D.disabled = true

func tutorialSecondStep1():
	$AnimationPlayer1.play("idle1")

func tutorialSecondStepComplete():
	secondStep = true

func tutorialThirdStep():
	secondStep = false
	$AnimationPlayer1.play("startingAnimation2")

func tutorialThirdStep1():
	$AnimationPlayer1.play("idle2")

func tutorialThirdStepComplete():
	thirdStep = true

func tutorialFourStep():
	thirdStep = false
	$AnimationPlayer1.play("endingAnimation2")

func tutorialFourStep1():
	get_node("/root/MainScene/CanvasLayer").atTutorialUseBlocade = false
	get_node("/root/MainScene/CanvasLayer/Control5/Label").text = "Double-click to use"
	fifthStep = true
	$AnimationPlayer1.play("startingAnimation2")

func tutorialFifthStep():
	fifthStep = false
	get_node("/root/MainScene/CanvasLayer").atTutorial = false
	$AnimationPlayer1.play("endingAnimation3")
	$Transparent/StaticBody2D/CollisionShape2D.disabled = true

func tutorialFifthStep1():
	$AnimationPlayer1.play("startingAnimation3")

func tutorialFifthStep2():
	$AnimationPlayer1.play("idle3")

func tutorialFifthStepComplete():
	sixthStep = true

func tutorialSixthStep():
	sixthStep = false
	$AnimationPlayer1.play("endingAnimation4")

func tutorialSixthStep0():
	$AnimationPlayer1.play("startingAnimation5")

func tutorialSixthStep1():
	$AnimationPlayer1.play("idle4")

func tutorialSixtStepComplete():
	seventhStep = true

func tutorialSevenStep():
	seventhStep = false
	$AnimationPlayer1.play("endingAnimation5")

func tutorialSevenStep1():
	seventhStep1 = true
	$AnimationPlayer1.play("startingAnimation6")

func tutorialSevenStep2():
	$AnimationPlayer1.play("idle5")

func tutorialSevenStepComplete():
	dummyDestroyed = false
	$Transparent2/StaticBody2D/CollisionShape2D.disabled = true
	$AnimationPlayer1.play("endingAnimation6")

func tutorialComplete():
	$AnimationPlayer1.play("endingAnimation7")
