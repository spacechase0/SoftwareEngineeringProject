extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func ready():
	$Flap.play()
	if !$Flap.playing: 
		$Flap.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
