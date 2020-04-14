extends KinematicBody2D

export var FRIENDLY : bool = false
var velocity : Vector2 = Vector2()

#const Player = preload("res://Player.gd")
#const Seagull = preload("res://Seagull.gd")

func _ready() -> void:
	pass

func _physics_process(_delta : float) -> void:
	velocity = move_and_slide(velocity, Vector2(0, 1))
	if get_slide_count() > 0:
		for i in range(0, get_slide_count()):
			var coll = get_slide_collision(i)
			if coll.collider.get_class() == "Seagull" and FRIENDLY:
				coll.collider.queue_free()
#			elif coll.collider is Player and not FRIENDLY:
#				var player = coll.collider as Player
#				player.hit(1)
		self.queue_free()
