extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/CenterContainer/VBoxContainer/Continue.grab_focus()

func _process(delta):
	if $MarginContainer/CenterContainer/VBoxContainer/Continue.is_hovered() == true:
		$MarginContainer/CenterContainer/VBoxContainer/Continue.grab_focus()
	if $MarginContainer/CenterContainer/VBoxContainer/Exit.is_hovered() == true:
		$MarginContainer/CenterContainer/VBoxContainer/Exit.grab_focus()
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$MarginContainer/CenterContainer/VBoxContainer/Continue.grab_focus()
		get_tree().paused = not get_tree().paused
		visible = not visible

func _on_Continue_pressed():
	get_tree().paused = not get_tree().paused
	visible = not visible

func _on_Exit_pressed():
	get_tree().quit()
