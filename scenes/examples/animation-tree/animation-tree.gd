extends KinematicBody2D

var speed = 80.0

func _physics_process(_delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walk")
		move_and_slide(input_vector * speed)
		$AnimationTree.set("parameters/Idle/blend_position", input_vector)
		$AnimationTree.set("parameters/Walk/blend_position", input_vector)
	
func _input(_event):
	if Input.is_action_just_pressed("ui_left"):
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_left", "Pressed")
	if Input.is_action_just_pressed("ui_right"):
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_right", "Pressed")
		
	if Input.is_action_just_pressed("ui_up"):
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_up", "Pressed")
	if Input.is_action_just_pressed("ui_down"):
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_down", "Pressed")
		
	if Input.is_action_just_released("ui_left"):
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_left", "Released")
	if Input.is_action_just_released("ui_right"):
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_right", "Released")
			
	if Input.is_action_just_released("ui_up"):
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_up", "Released")
	if Input.is_action_just_released("ui_down"):
		Signals.emit_signal("KeyboardHudPerformButtonAnimation", "ui_down", "Released")
