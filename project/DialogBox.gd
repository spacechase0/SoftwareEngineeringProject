extends RichTextLabel


var dialog = ["Hey! This is a dialog box! In H2Go, this will help you figure out the story and any tutorials!"]
var page = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	set_bbcode(dialog[page])
	set_visible_characters(0)
			

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)
	
