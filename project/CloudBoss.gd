extends KinematicBody2D

export var speed : float = 100
export var FOLLOW_PATH : NodePath
export var LIGHTNING_TIMER = 3
export var MAX_HEALTH = 20
export var ScenetoTrigger : PackedScene = preload("res://Cutscene1.tscn")

const CloudBossProjectile_scene = preload("res://CloudBossProjectile.tscn")

var health : int = MAX_HEALTH
var lightning_timer : float = LIGHTNING_TIMER

signal health_lost(percent)

var velocity : Vector2 = Vector2.ZERO

var path : Path2D
var path_points
var curr_path_point : int = 0
var dir : int = 1

func get_class():
	return "CloudBoss"

func _ready():
	path = get_node(FOLLOW_PATH)
	path_points = path.curve.get_baked_points()

func _physics_process(delta):
	var target = path.global_position + path_points[curr_path_point]
	while global_position.distance_to(target) < 16:
		curr_path_point += dir
		if curr_path_point < 0 || curr_path_point >= path_points.size():
			dir = -dir
			curr_path_point += dir
		target = path_points[curr_path_point]
		
	velocity = (target - position).normalized() * speed
	var coll = move_and_collide(velocity * delta)
	if coll:
		velocity = velocity.slide(coll.normal)
		if coll.collider.get_class() == "Player":
			coll.collider.hit(1)
	
	lightning_timer -= delta
	if lightning_timer <= 0:
		lightning_timer = LIGHTNING_TIMER
		
		var x = ($ProjectileSpawn as Node2D).global_position.x
		var y = ($ProjectileSpawn as Node2D).global_position.y
		for i in range(0, 5):
			var lightning = CloudBossProjectile_scene.instance()
			var angle = get_node("../Player").global_position.angle_to_point(Vector2(x, y))
			angle += ((i - 2)  * 20) * PI / 180
			lightning.velocity.x = cos(angle) * 200
			lightning.velocity.y = sin(angle) * 200
			get_parent().add_child(lightning)
			lightning.global_position.x = x
			lightning.global_position.y = y

func hit(dmg : int) -> void:
	if health > 0:
		health -= dmg
		emit_signal("health_lost", health / float(MAX_HEALTH))
		if health <= 0:
			self.queue_free()
			get_tree().change_scene_to(ScenetoTrigger)
