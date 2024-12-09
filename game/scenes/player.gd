extends CharacterBody2D

@onready var sound: AudioStreamPlayer = $sound

const SPEED = 150.0

var furniture_in_range = [] # nearby furniture objs
var held_furniture = null # currently held furniture
var facing_direction = Vector2(1, 0) # default to facing right

func _ready():
	for furniture in get_tree().get_nodes_in_group("furniture"):
		furniture.connect("entered_range", Callable(self, "add_furniture_to_range"))
		furniture.connect("exited_range", Callable(self, "remove_furniture_from_range"))

func _process(delta):
	var x_direction = 0
	var y_direction = 0
	
	if Input.is_action_pressed("move_right"):
		x_direction = 1
		facing_direction = Vector2(1, 0)  # facing right
		$AnimatedSprite2D.animation = "RIGHT_1"
		
	elif Input.is_action_pressed("move_left"):
		x_direction = -1
		facing_direction = Vector2(-1, 0)  # facing left
		$AnimatedSprite2D.animation = "LEFT"
		
	elif Input.is_action_pressed("move_down"):
		y_direction = 1
		facing_direction = Vector2(0, 1)  # facing down
		$AnimatedSprite2D.animation = "DOWN"

	elif Input.is_action_pressed("move_up"):
		y_direction = -1
		facing_direction = Vector2(0, -1)  # facing up
		$AnimatedSprite2D.animation = "UP"

	if Input.is_action_just_pressed("ui_pickup"):
		attempt_pickup_or_drop()
	
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
	
func attempt_pickup_or_drop():
	if held_furniture:
		# drop held furniture
		held_furniture.drop()
		held_furniture = null
		sound.play()
		await sound.finished
	else:
		# find closest valid furniture to pick up
		var closest_furniture = get_closest_furniture()
		if closest_furniture:
			closest_furniture.pickup(self)
			sound.play()
			held_furniture = closest_furniture
			await sound.finished

func get_closest_furniture():
	var closest = null
	var min_distance = INF

	for furniture in furniture_in_range:
		if furniture.is_player_close and furniture.is_facing_furniture(self):
			var distance = global_position.distance_to(furniture.global_position)
			if distance < min_distance:
				min_distance = distance
				closest = furniture

	return closest

# called when furniture object enters range
func add_furniture_to_range(furniture):
	if furniture not in furniture_in_range:
		furniture_in_range.append(furniture)

# called when furniture object leaves range
func remove_furniture_from_range(furniture):
	furniture_in_range.erase(furniture)
	
func get_fixed_direction():
	if facing_direction == Vector2(1, 0):
		return "right"
	elif facing_direction == Vector2(-1, 0):
		return "left"
	elif facing_direction == Vector2(0, -1):
		return "up"
	elif facing_direction == Vector2(0, 1):
		return "down"
	return "unknown"
	


func _on_button_pressed():
	print("menu pressed")
	sound.play()
	await sound.finished
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
