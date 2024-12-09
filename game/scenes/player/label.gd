extends Label

var time_left: float = 91.0  # Starting time in seconds

func _process(delta: float):
	if time_left > 0:
		time_left -= delta
		var mins: int = int(time_left) / 60
		var seconds: int = int(time_left) % 60
		text = "%02d:%02d" % [mins, seconds]
	else:
		text = "Time's Up You FAILED!!!!!"
		get_tree().paused = true
