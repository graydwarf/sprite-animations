extends Node2D

# Keyboard Buttons:
#   https://opengameart.org/content/keyboard-keys-1

onready var _leftButton = $LeftButton
onready var _rightButton = $RightButton
onready var _upButton = $UpButton
onready var _downButton = $DownButton

var _rightButtonPosition = Vector2(64, 0)

var _pressedScale = Vector2(0.95, 0.95)
var _defaultScale = Vector2(1, 1)

var _buttonPressed = false
var _inputType = ""
var _moveDirection = ""

func _ready():
	Signals.connect("KeyboardHudPerformButtonAnimation", self, "KeyboardHudPerformButtonAnimation")

func EnableButton(buttonName):
	if buttonName == "Left":
		_leftButton.texture = load("res://scenes/toolbox/examples/common-support/keyboard-hud/assets/keyboard-left-32x32.png")
	elif buttonName == "Right":
		_rightButton.texture = load("res://scenes/toolbox/examples/common-support/keyboard-hud/assets/keyboard-right-32x32.png")
	elif buttonName == "Up":
		_upButton.texture = load("res://scenes/toolbox/examples/common-support/keyboard-hud/assets/keyboard-up-32x32.png")
	elif buttonName == "Down":
		_downButton.texture = load("res://scenes/toolbox/examples/common-support/keyboard-hud/assets/keyboard-down-32x32.png")
		
func KeyboardHudPerformButtonAnimation(inputName, toggleDirection):
	if toggleDirection == "Pressed":	
		if inputName == "ui_left":
			AnimateButtonPressed(_leftButton)
		elif inputName == "ui_right":
			AnimateButtonPressed(_rightButton)
		elif inputName == "ui_up":
			AnimateButtonPressed(_upButton)
		elif inputName == "ui_down":
			AnimateButtonPressed(_downButton)
	elif toggleDirection == "Released":
		if inputName == "ui_left":
			AnimateButtonReleased(_leftButton)
		elif inputName == "ui_right":
			AnimateButtonReleased(_rightButton)
		elif inputName == "ui_up":
			AnimateButtonReleased(_upButton)
		elif inputName == "ui_down":
			AnimateButtonReleased(_downButton)

func AnimateButtonPressed(button):
	if button.rect_scale == _pressedScale:
		# Already pressed
		return
		
	button.rect_scale = _pressedScale
	button.rect_position += Vector2(0, 2)
	button.self_modulate = Color(1.0, 1.0, 1.0, 0.7)

func AnimateButtonReleased(button):
	if button.rect_scale == _defaultScale:
		# Already released
		return
		
	button.rect_scale = _defaultScale
	button.rect_position -= Vector2(0, 2)
	button.self_modulate = Color(1.0, 1.0, 1.0, 1.0)


