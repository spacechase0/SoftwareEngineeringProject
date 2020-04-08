extends HBoxContainer


var heart_full = preload("res://dropheart.png")
var heart_empty = preload("res://dropheartempty.png")


func _on_Player_health_lost(value):
	for i in get_child_count():
		if value > i:
			get_child(i).texture = heart_full
		else:
			get_child(i).texture = heart_empty
	
