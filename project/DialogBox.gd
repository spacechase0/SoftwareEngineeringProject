extends RichTextLabel


var dialog = []
var page = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_bbcode(dialog[page])
	set_visible_characters(0)
	set_process_input(true)
	#get_tree().get_root().set_disable_input(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if event is InputEventKey:
		if event.is_action("advance") && event.pressed:
			if get_visible_characters() > get_total_character_count():
				if page < dialog.size()-1:
					page += 1
					set_bbcode(dialog[page])
					set_visible_characters(0)
				else:
					get_parent().queue_free()
				#	get_tree().get_root().set_disable_input(false)
			else:
				set_visible_characters(get_total_character_count())

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)
	
