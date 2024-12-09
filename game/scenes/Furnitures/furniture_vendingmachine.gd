extends Area2D

var is_held = false
var player = null
var is_player_close = false

const OFFSET = 24  # fixed offset distance

func _ready():
	$PickUpCue.visible = false

func _process(delta):
	if is_held and player:
		# get player facing direction
		var direction = player.get_fixed_direction()

		# calc offset based on direction
		var offset = Vector2()
		match direction:
			"up":
				offset = Vector2(0, -OFFSET)
			"down":
				offset = Vector2(0, OFFSET)
			"left":
				offset = Vector2(-OFFSET, 0)
			"right":
				offset = Vector2(OFFSET, 0)

		# update furniture position
		global_position = player.global_position + offset
	else:
		# update visual cue
		if is_player_close and player and is_facing_furniture(player):
			$PickUpCue.visible = true
		else:
			$PickUpCue.visible = false

signal entered_range(player)
signal exited_range(player)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		if is_held:
			return  # ignore if already held
		player = body
		is_player_close = true
		emit_signal("entered_range", self)

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		if is_held:
			return  # ignore if already held
		player = null
		is_player_close = false
		emit_signal("exited_range", self)

func pickup_or_drop(player_node):
	if is_held:
		drop()
	else:
		if not is_player_close:
			return
		if not is_facing_furniture(player_node):
			return
		pickup(player_node)

func pickup(player_node):
	is_held = true
	player = player_node
	$PickUpCue.visible = false

func drop():
	is_held = false
	player = null
	$PickUpCue.visible = false

func is_facing_furniture(player_node):
	var direction_to_furniture = (global_position - player_node.global_position).normalized()
	var player_facing_direction = player_node.facing_direction
	return direction_to_furniture.dot(player_facing_direction) > 0.7
