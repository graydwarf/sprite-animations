extends KinematicBody2D

# Keyboard Buttons:
#   https://opengameart.org/content/keyboard-keys-1

# Animated Sprite Tutorial:
#   https://docs.godotengine.org/en/stable/tutorials/2d/2d_sprite_animation.html

var speed = 80.0
var _facingDirection = ""
onready var _animatedSprite = $AnimatedSprite

func _physics_process(_delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector == Vector2.ZERO:
		_animatedSprite.stop()
	else:
		if _facingDirection == "ui_left":
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
			
		_animatedSprite.play("Jump")
		move_and_slide(input_vector * speed)
	
func _input(_event):
	if Input.is_action_just_pressed("ui_left"):
		_facingDirection = "ui_left"
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_left", "Pressed")
	if Input.is_action_just_pressed("ui_right"):
		_facingDirection = "ui_right"
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_right", "Pressed")
		
	if Input.is_action_just_pressed("ui_up"):
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_up", "Pressed")
	if Input.is_action_just_pressed("ui_down"):
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_down", "Pressed")
		
	if Input.is_action_just_released("ui_left"):
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_left", "Released")
		if Input.is_action_pressed("ui_right"):
			_facingDirection = "ui_right"
	if Input.is_action_just_released("ui_right"):
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_right", "Released")
		if Input.is_action_pressed("ui_left"):
			_facingDirection = "ui_left"
			
	if Input.is_action_just_released("ui_up"):
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_up", "Released")
	if Input.is_action_just_released("ui_down"):
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_down", "Released")
