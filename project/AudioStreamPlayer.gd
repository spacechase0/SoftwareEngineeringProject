extends AudioStreamPlayer

#current melodies
var adventureTheme


func _ready():
	set_process(true)
	adventureTheme = self.get_stream()
	self.play()

#currently this just alternates between two of the melodies to demonstrate them
#func _process(delta):

