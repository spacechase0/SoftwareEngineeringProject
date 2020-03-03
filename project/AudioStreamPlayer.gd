extends AudioStreamPlayer

#current melodies
var adventureTheme
var calmTheme
var bossTheme

func _ready():
	set_process(true)
	adventureTheme = self.get_stream()
	calmTheme = load("Relaxing sad melody.tres")
	self.play()

#currently this just alternates between two of the melodies to demonstrate them
func _process(delta):
	if(self.is_playing()) != true: #change from one song to another
		if(self.get_stream() == adventureTheme):
			self.set_stream(calmTheme) 
		else:
			self.set_stream(adventureTheme)
		self.play()
