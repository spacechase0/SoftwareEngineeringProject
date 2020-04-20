extends KinematicBody2D

export var VINE_TIMER = 7
export var MAX_HEALTH = 25
export var ScenetoTrigger : PackedScene = preload("res://Cutscene2.tscn")

var health : int = MAX_HEALTH
var vine_timer : float = VINE_TIMER

const FlowerVine_Scene = preload("res://FlowerVine.tscn")
signal health_lost(percent)

func get_class():
	return "FlowerBoss"

func _physics_process(delta):
	vine_timer -= delta
	if vine_timer <= 0:
		vine_timer = VINE_TIMER
		
		var minX = ($LeftVineBorder as Node2D).global_position.x
		var maxX = ($RightVineBorder as Node2D).global_position.x
		var y = ($LeftVineBorder as Node2D).global_position.y
		for i in range(0, 7):
			var vine = FlowerVine_Scene.instance()
			vine.global_position.x = rand_range(minX, maxX)
			vine.global_position.y = y
			get_parent().add_child(vine)

func hit(dmg : int) -> void:
	if health > 0:
		health -= dmg
		emit_signal("health_lost", health / float(MAX_HEALTH))
		if health <= 0:
			$Defeat.play()
			self.queue_free()
			get_tree().change_scene_to(ScenetoTrigger)
