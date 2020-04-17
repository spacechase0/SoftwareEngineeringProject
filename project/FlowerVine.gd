extends KinematicBody2D


export var VINE_GROWTH_TIME : float= 2
export var VINE_LIVE_TIME : float = 2

var vine_time : float = VINE_GROWTH_TIME

func get_class():
	return "FlowerVine"

func _physics_process(delta : float):
	if vine_time > 0:
		vine_time -= delta
		if vine_time <= 0:
			($DisplayFull as Node2D).visible = true
			$DisplayFull/AnimatedSprite.play("default");
			($DisplaySprout as Node2D).visible = false
			($CollisionShape2D as CollisionShape2D).disabled = false
			

	else:
		vine_time -= delta
		#$DisplayFull/AnimatedSprite.visible = false;
		$DisplaySprout/vinetip.visible = true;
		if vine_time <= -VINE_LIVE_TIME:
			self.queue_free()
