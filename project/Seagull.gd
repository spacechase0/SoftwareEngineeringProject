extends KinematicBody2D

export var speed : float = 100
export var follow_path : NodePath
signal damage
const Projectile = preload("res://Projectile.gd")

var velocity : Vector2 = Vector2.ZERO

export (int) var damage_given = 1

var path : Path2D
var path_points
var curr_path_point : int = 0
var dir : int = 1

func _ready() -> void:
	path = get_node(follow_path) as Path2D
	path_points = path.curve.get_baked_points()

func _physics_process(delta) -> void:
	($CollisionGull as CollisionPolygon2D).disabled = false
	$CollisionGull/Gull.play("default")
	
	var target = path.global_position + path_points[curr_path_point]
	while global_position.distance_to(target) < 16:
		$Flap.play()
			
		curr_path_point += dir
		if curr_path_point < 0 || curr_path_point >= path_points.size():
			if curr_path_point < 0:
				$CollisionGull/Gull.flip_h = false
			else:
				$CollisionGull/Gull.flip_h = true
			dir = -dir
			curr_path_point += dir
		target = path_points[curr_path_point]
	
	velocity = (target - position).normalized() * speed
	var coll = move_and_collide(velocity * delta)
	if coll:
		velocity = velocity.slide(coll.normal)
		if coll.collider is Projectile:
			var proj = coll.collider as Projectile
			if proj.FRIENDLY:
				self.queue_free()
				proj.queue_free()
		if coll.collider is KinematicBody2D:
			emit_signal("damage", damage_given)