extends AudioStreamPlayer

#current melody
var menu


func _ready():
	set_process(true)
	menu = self.get_stream()
	self.play()
