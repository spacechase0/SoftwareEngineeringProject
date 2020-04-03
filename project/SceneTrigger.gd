extends Area2D

export var SceneToTrigger : PackedScene

const Player = preload("res://Player.gd")

func _on_SceneTrigger_body_entered(body):
	if body is Player:
		get_tree().change_scene_to(SceneToTrigger)
