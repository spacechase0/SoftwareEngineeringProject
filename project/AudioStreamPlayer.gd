extends AudioStreamPlayer

#current melodies
var bossTheme


func _ready():
	set_process(true)
	bossTheme = self.get_stream()
	self.play()

#currently this just alternates between two of the melodies to demonstrate them
#func _process(delta):

