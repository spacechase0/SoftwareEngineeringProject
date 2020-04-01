extends Node2D

var triggered : bool = false
export var Entries : PoolStringArray = []

const DialogBox = preload("res://DialogBox.tscn")
const Player = preload("res://Player.gd")

func _on_Area2D_body_entered(body) -> void:
	if body is Player and not triggered:
		triggered = true
		var dialog = DialogBox.instance()
		dialog.find_node("RichTextLabel").dialog = Entries
		var canvas = get_tree().get_root().find_node("CanvasLayer", true, false)
		var dialogContainer = canvas.find_node("DialogContainer")
		dialogContainer.add_child(dialog)
