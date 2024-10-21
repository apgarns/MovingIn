extends Control

@onready var button_pressed: AudioStreamPlayer = $button_press

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	button_pressed.play()
	await button_pressed.finished
	print("start pressed")
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_settings_button_pressed() -> void:
	button_pressed.play()
	await button_pressed.finished
	print("settings pressed")


func _on_exit_button_pressed() -> void:
	button_pressed.play()
	await button_pressed.finished
	print("exit pressed")
	get_tree().quit()
