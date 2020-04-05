extends AudioStreamPlayer2D

const Player = preload("res://Player.gd")
var shoot_sound

func _ready():
	shoot_sound = get_node("bloop.wav")
	set_process_input(true)

func _input(event):
	if Input.is_action_pressed("shoot"):
		shoot_sound.play()
