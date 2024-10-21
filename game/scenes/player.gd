extends CharacterBody2D

const SPEED = 150.0

func _process(delta):
	var x_direction = 0
	var y_direction = 0
	
	if Input.is_action_pressed("move_right"):
		x_direction =+1
		$AnimatedSprite2D.animation = "RIGHT_1"
	if Input.is_action_pressed("move_left"):
		x_direction =-1
		$AnimatedSprite2D.animation = "LEFT"

		
	if Input.is_action_pressed("move_down"):
		y_direction =+1
		$AnimatedSprite2D.animation = "DOWN"

	if Input.is_action_pressed("move_up"):
		y_direction =-1
		$AnimatedSprite2D.animation = "UP"

		
	
	# Handle horizontal movement
	if x_direction:
		velocity.x = x_direction * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Handle vertical movement
	if y_direction:
		velocity.y = y_direction * SPEED

	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	

	# If there is no movement, stop the animation
	if x_direction == 0 and y_direction == 0:
		$AnimatedSprite2D.stop()
	else:
		$AnimatedSprite2D.play()

	# Move the character
	move_and_slide()
