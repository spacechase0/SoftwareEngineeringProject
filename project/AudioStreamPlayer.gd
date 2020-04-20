extends AudioStreamPlayer

#current melody
var thirdtheme


func _ready():
	set_process(true)
	thirdtheme = self.get_stream()
	self.play()
