extends KinematicBody2D

export var FRIENDLY : bool = false
var velocity : Vector2 = Vector2()

func _ready() -> void:
	pass

func _physics_process(delta : float) -> void:
	velocity = move_and_slide(velocity, Vector2(0, 1))
