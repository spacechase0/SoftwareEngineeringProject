extends Area2D

const Player = preload("res://Player.gd")

func _on_ReloadTrigger_body_entered(body):
	if body is Player:
		get_tree().reload_current_scene()
