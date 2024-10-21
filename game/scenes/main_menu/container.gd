extends Container


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_ScreenResolutionChanged():
	# Update button sizes when resolution changes
	$Container.rect_size = Vector2(get_viewport().get_visible_rect().size.x / 2, 20)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
