extends Node2D

@onready var timer = $Countdown_Timer
@onready var timer_label = $Countdown_UI

var time_left = 90

func _ready() -> void:
	timer.start()
	update_timer_display()

func _on_CountdownTimer_timeout():
	print("timer ticked")
	time_left -= 1
	update_timer_display()
	
	if time_left <= 0:
		fail_state()
		
func update_timer_display():
	var mins = int(time_left / 60)
	var seconds = time_left % 60
	timer_label.text = "%02d:%02d" % [mins, seconds]
	
func fail_state():
	print("time's up, you failed!")
	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
