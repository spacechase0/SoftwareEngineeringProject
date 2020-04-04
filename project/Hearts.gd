extends HBoxContainer


var heart_full = preload("res://hud_heartFull.png")

func _ready():
	visible = not visible

func _on_Player_health_lost(value):
	visible = visible
	for i in get_child_count():
		get_child(i).visible = value > i
